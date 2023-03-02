import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

enum StatusEnum { connected, connecting, close, colsing }

class WebSocketDemo extends StatefulWidget {
  const WebSocketDemo({super.key});

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  StatusEnum _isConnected = StatusEnum.close;
  late IOWebSocketChannel channel;
  final String _url = "wss://echo.websocket.org";
  StreamController<StatusEnum> socketStatusController =
      StreamController<StatusEnum>();

  @override
  void dispose() {
    _closeAction();
    super.dispose();
  }

  @override
  void initState() {
    _connectedAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("websocket demo (${_connecteStatus()})"),
        centerTitle: true,
      ),
      body: _bodyContent(),
    );
  }

  Widget _bodyContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  _connectedAction();
                },
                child: const Text("连接")),
            ElevatedButton(
                onPressed: () {
                  _disConnectedAction();
                },
                child: const Text("断开")),
            ElevatedButton(
                onPressed: () {
                  _secondAction("你好22");
                },
                child: const Text("发送")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _messageList(),
      ],
    );
  }

  ///连接
  Future<bool> _connectedAction() async {
    if (_isConnected == StatusEnum.close) {
      _isConnected = StatusEnum.connecting;
      socketStatusController.add(_isConnected);
      channel = await IOWebSocketChannel.connect(Uri.parse(_url));

      _isConnected = StatusEnum.connected;
      socketStatusController.add(_isConnected);
      return true;
    }
    setState(() {});
    return false;
  }

  ///关闭
  void _closeAction() {
    channel.sink.close();
    socketStatusController.close();
    _isConnected = StatusEnum.close;
    setState(() {});
  }

  ///断开连接
  void _disConnectedAction() async {
    if (_isConnected == StatusEnum.connected) {
      _isConnected = StatusEnum.colsing;
      socketStatusController.add(_isConnected);
      await channel.sink.close(3000, "主动关闭");
      _isConnected = StatusEnum.close;
      socketStatusController.add(_isConnected);
    }
    setState(() {});
  }

  ///发送
  bool _secondAction(String text) {
    print("发送");
    if (text.isEmpty) {
      print("发送内容为空");
      return false;
    }

    if (_isConnected == StatusEnum.connected) {
      channel.sink.add(text);
      return true;
    }
    return false;
  }

  ///获取状态值
  String _connecteStatus() {
    String status = "";
    switch (_isConnected) {
      case StatusEnum.connected:
        status = "已连接";
        break;
      case StatusEnum.connecting:
        status = "连接中";
        break;
      case StatusEnum.close:
        status = "已关闭";
        break;
      case StatusEnum.colsing:
        status = "关闭中";
        break;
      default:
    }
    return status;
  }

  Widget _messageList() {
    return StreamBuilder<StatusEnum>(
      builder: (context, snapshot) {
        if (snapshot.data == StatusEnum.connected) {
          return StreamBuilder(
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                return Container(
                  child: Text("收到的消息 ${snapshot1.data}"),
                );
              } else if (snapshot1.hasError) {
                return const Text("出错了");
              } else {
                return const Text("已经连接，还没数据呢");
              }
            },
            stream: channel.stream,
          );
        } else {
          return Text(_connecteStatus());
        }
      },
      initialData: StatusEnum.close,
      stream: socketStatusController.stream,
    );
  }
}
