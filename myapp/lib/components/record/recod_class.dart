//录音类
import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class Record {
  //私有构造函数
  Record._internal();
  static final Record _singleton = Record._internal();
  //工厂构造函数
  factory Record() => _singleton;

  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();

  ///是否有权限
  Future<bool> hasPermission() async {
    Permission permission = Permission.microphone;
    PermissionStatus status = await permission.status;
    return status == PermissionStatus.granted;
  }

  ///初始化
  void initRecorder() async {
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
  }

  ///销毁
  void disposeRecorder() {
    recorderModule.closeRecorder();
  }

  ///end
}
