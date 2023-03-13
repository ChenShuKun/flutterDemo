import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:myapp/components/record/play_class.dart';
import 'package:myapp/components/record/recod_class.dart';
import 'package:myapp/tools/tips.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class RecordAudioPage extends StatefulWidget {
  const RecordAudioPage({super.key});

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  late String _recordPath;
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  RecorderState _recordState = RecorderState.isStopped; //录音状态
  String statusInfoStr = "没有录音";
  @override
  void initState() {
    // init();
    Record().initRecorder();
    Player().initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Record().disposeRecorder();
    Player().disposePlayer();

    recorderModule.closeRecorder();
    playerModule.closePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" 录音 和 播放"),
        centerTitle: true,
      ),
      body: _bodyContent(),
    );
  }

  Widget _bodyContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("原来的"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    recordAction();
                  },
                  child: const Text("录音")),
              ElevatedButton(
                  onPressed: () {
                    stopRecordAction();
                    Tips.showToast("结束录音");
                  },
                  child: const Text("结束录音")),
              ElevatedButton(
                  onPressed: () {
                    deleteAction();
                  },
                  child: const Text("删除")),
              ElevatedButton(
                  onPressed: () {
                    playAction();
                  },
                  child: const Text("播放")),
            ],
          ),
          Text("封装：$statusInfoStr"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Tips.showToast("开始录音");
                    setState(() {
                      statusInfoStr = "录制中";
                    });
                    Record().startRecord(callBack: (str) {
                      print("录制中");
                    });
                  },
                  child: const Text("录音-2")),
              ElevatedButton(
                  onPressed: () {
                    Tips.showToast("结束录音");
                    Record().stopRecord();
                    setState(() {
                      statusInfoStr = "录制结束";
                    });
                  },
                  child: const Text("结束录音-2")),
              ElevatedButton(
                  onPressed: () {
                    Tips.showToast("删除录音");
                  },
                  child: const Text("删除-2")),
              ElevatedButton(
                  onPressed: () {
                    String path = Record().recordPath ?? "";
                    Player().startPlay(
                      path,
                      callBack: (code, message) {
                        if (code == 199) {
                          setState(() {
                            statusInfoStr = "开始播放";
                          });
                        } else if (code == 200) {
                          setState(() {
                            statusInfoStr = "播放完毕";
                          });
                        } else {
                          setState(() {
                            statusInfoStr = message;
                          });
                        }
                      },
                    );
                  },
                  child: const Text("播放-2")),
            ],
          ),
        ],
      ),
    );
  }

  ///--封装 开始

  ///--封装 结束
  void init() async {
    //开启录音
    await recorderModule.openRecorder();
    //设置订阅计时器
    await recorderModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));

    //设置音频
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    await playerModule.closePlayer();
    await playerModule.openPlayer();
    await playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
  }

  //录音
  void recordAction() async {
    bool status = await getPermissionStatus();
    if (status == false) {
      return;
    }

    Tips.showToast("开始录音");
    Directory tempDir = await getApplicationDocumentsDirectory();
    var time = DateTime.now().millisecondsSinceEpoch;
    String path = '${tempDir.path}-$time${ext[Codec.aacADTS.index]}';

    print('===>  准备开始录音');
    await recorderModule.startRecorder(
        toFile: path,
        codec: Codec.aacADTS,
        bitRate: 8000,
        sampleRate: 8000,
        audioSource: AudioSource.microphone);
    print('===>  开始录音');

    recorderModule.onProgress!.listen((e) {
      if (e != null && e.duration != null) {
        print(" 录音监听  $e");
      }
    });
    setState(() {
      _recordState == RecorderState.isRecording;
      _recordPath = path;
    });

    ///
  }

  //结束录音
  void stopRecordAction() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder===> fliePath:$_recordPath');
      setState(() {
        _recordState == RecorderState.isStopped;
      });
    } catch (err) {
      print(' stopRecorder error: $err');
    }
  }

  //删除
  void deleteAction() {
    Tips.showToast("删除");
  }

  //播放
  void playAction() {
    Tips.showToast("播放");
    if (_recordPath.isEmpty) {
      return;
    }
    print("111111");
    startPlayer(_recordPath);
  }

  ///开始播放，这里做了一个播放状态的回调
  void startPlayer(path, {Function(dynamic)? callBack}) async {
    try {
      if (path.contains('http')) {
        await playerModule.startPlayer(
            fromURI: path,
            codec: Codec.mp3,
            sampleRate: 44000,
            whenFinished: () {
              stopPlayer();
              callBack!(0);
            });
        setState(() {});
      } else {
        //判断文件是否存在
        if (await _fileExists(path)) {
          print("33333");
          if (playerModule.isPlaying) {
            playerModule.stopPlayer();
          }
          await playerModule.startPlayer(
              fromURI: path,
              codec: Codec.aacADTS,
              sampleRate: 44000,
              whenFinished: () {
                stopPlayer();
                callBack!(0);
              });
        } else {}
      }
      //监听播放进度
      playerModule.onProgress!.listen((e) {
        print("播放 进度 $e");
      });
      callBack!(1);
    } catch (err) {
      callBack!(0);
    }
  }

  /// 结束播放
  void stopPlayer() async {}

  ///获取播放状态
  Future getPlayState() async {
    return await playerModule.getPlayerState();
  }

  /// 释放播放器
  void releaseFlauto() async {
    try {
      await playerModule.closePlayer();
    } catch (e) {
      print(e);
    }
  }

  /// 判断文件是否存在
  Future _fileExists(String path) async {
    return await File(path).exists();
  }

  Future<bool> getPermissionStatus() async {
    Permission permission = Permission.microphone;
    //granted 通过，denied 被拒绝，permanentlyDenied 拒绝且不在提示
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      requestPermission(permission);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isRestricted) {
      requestPermission(permission);
    } else {}
    return false;
  }

  ///申请权限
  void requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  ///end
}
