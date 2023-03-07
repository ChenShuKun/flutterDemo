//录音类
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart'
    as source;

class Record {
  //私有构造函数
  Record._internal() {
    //此处进行初始化操作
  }
  static final Record singleton = Record._internal();
  //工厂构造函数
  factory Record() => singleton;

  final FlutterSoundRecorder _recorderModule = FlutterSoundRecorder();
  String? recordPath; //录制路径

  ///是否有权限
  Future<bool> hasPermission() async {
    Permission permission = Permission.microphone;
    PermissionStatus status = await permission.status;
    return status == PermissionStatus.granted;
  }

  ///初始化
  void initRecorder() async {
    //开启录音
    await _recorderModule.openRecorder();
    //设置订阅计时器
    await _recorderModule
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
  }

  //录音
  void startRecord(
      {String path = "",
      String fileName = "",
      Codec codec = Codec.aacADTS,
      Function(String)? callBack}) async {
    bool permission = await hasPermission();

    if (permission == false) {
      print("没有 权限 ");
      return;
    }
    if (fileName.isEmpty) {
      fileName = DateTime.now().millisecondsSinceEpoch.toString();
    }
    Directory documentDir = await getApplicationDocumentsDirectory();
    String rootDir = documentDir.path;
    if (path.isNotEmpty) {
      rootDir = rootDir + path;
    }
    String toPath = '$rootDir/$fileName${ext[codec.index]}';
    var dir = File(toPath);
    var exist = await dir.exists();
    if (!exist) {
      await dir.create(recursive: true);
    }
    print('===>  准备开始录音  path =$toPath');
    await _recorderModule.startRecorder(
        toFile: toPath,
        codec: Codec.aacADTS,
        bitRate: 8000,
        sampleRate: 8000,
        audioSource: source.AudioSource.microphone);
    print('===>  开始录音');
    _recorderModule.onProgress!.listen((e) {
      if (e != null && e.duration != null) {
        print("eeee $e");
        if (callBack != null) {
          callBack("");
        }
      }
    });

    ///
  }

  //结束录音
  void stopRecord() async {
    try {
      _recorderModule.stopRecorder().then((value) {
        recordPath = value;
      });
      // if (_recorderModule != null) {
      //  _recorderSubscription.cancel();
      //  _recorderSubscription = null;
      // }
    } catch (err) {
      print(' stopRecorder error: $err');
    }
  }

  ///销毁
  void disposeRecorder() {
    _recorderModule.closeRecorder();
  }

  ///end
}
