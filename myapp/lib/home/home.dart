import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/home/DetailVC/Hero.dart';
import 'package:myapp/home/DetailVC/getx_study.dart';
import 'package:myapp/home/DetailVC/image_picker.dart';
import 'package:myapp/home/DetailVC/news/news_list.dart';
import 'package:myapp/home/DetailVC/record_audio.dart';
import 'package:myapp/home/DetailVC/web_socket.dart';

import 'DetailVC/base_widget_study.dart';
import 'DetailVC/play_tab.dart';

class HomeDemo extends StatefulWidget {
  const HomeDemo({super.key});

  @override
  State<HomeDemo> createState() => _HomePageState();
}

class _HomePageState extends State<HomeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Demo"),
        centerTitle: true,
      ),
      body: _getGraidListBody(), //_getListBody(),
    );
  }

  Widget _getListBody() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final item = _getList()[index];
          return ListTile(
            onTap: () {
              print("object");
              _tapAction(int.parse(item["tag"]));
            },
            textColor: Colors.white,
            title: Text(
              item["name"],
            ),
            subtitle: Text(item["subName"]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 2,
            color: Colors.black45,
          );
        },
        itemCount: _getList().length);
  }

  Widget _getGraidListBody() {
    final list = _getList();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          final item = list[index];
          return Container(
            color: Colors.red,
            child: ListTile(
              onTap: () {
                _tapAction(int.parse(item["tag"]));
              },
              textColor: Colors.white,
              title: Text(item["name"]),
              subtitle: Text(item["subName"]),
            ),
          );
        },
      ),
    );
  }

  List _getList() {
    List list = [
      {"name": "hero Demo", "subName": "动画跳转", "tag": "100"},
      {"name": "玩tab", "subName": "动画跳转", "tag": "110"},
      {"name": "基本组件", "subName": "基本组件的学习", "tag": "120"},
      {"name": "image picker", "subName": "获取相册", "tag": "130"},
      {"name": "WebSocket", "subName": "socket demo", "tag": "140"},
      {"name": "录音和播放", "subName": "学习录音和播放", "tag": "150"},
      {"name": " GetX ", "subName": "学习GetX", "tag": "160"},
      {"name": " 新闻列表 ", "subName": "学习GetX 做新闻列表", "tag": "170"},
    ];
    return list;
  }

  void _tapAction(int tag) {
    switch (tag) {
      case 100:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const HeroPageDemo();
          },
        ));
        break;
      case 110:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const PlayPage();
          },
        ));
        break;
      case 120:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const BaseWidgetStudy();
          },
        ));
        break;
      case 130:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const ImagePickerDemo();
          },
        ));
        break;
      case 140:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const WebSocketDemo();
          },
        ));
        break;
      case 150:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const RecordAudioPage();
          },
        ));
        break;
      case 160:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const GetXStudyPage();
          },
        ));
        break;
      case 170:
        Get.to(const NewsListPage());
        break;
      default:
    }
  }
}
