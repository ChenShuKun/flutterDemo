import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class Player {
  //私有构造函数
  Player._internal() {
    //此处进行初始化操作
  }
  static final Player singleton = Player._internal();
  //工厂构造函数
  factory Player() => singleton;

  FlutterSoundPlayer _playerModule = FlutterSoundPlayer();

  void initPlayer() async {
    //开启播放
    await _playerModule.openPlayer();
    await _playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 10));
  }

  ///开始播放，这里做了一个播放状态的回调
  void startPlay(path, {Function(int code, String message)? callBack}) async {
    print("111播放的 path $path");
    if (path.isEmpty) {
      if (callBack != null) {
        callBack(0, "播放路径为空");
      }
      return;
    }
    try {
      if (path.contains('http') || path.contains('https')) {
        await _playerModule.startPlayer(
            fromURI: path,
            codec: Codec.mp3,
            sampleRate: 44000,
            whenFinished: () {
              if (callBack != null) {
                callBack(200, "播放完毕");
              }
            });
      } else {
        //判断文件是否存在
        bool fileExist = await _fileExists(path);
        if (!fileExist) {
          if (callBack != null) {
            callBack(0, "播放文件不存在");
          }
          return;
        }
        if (_playerModule.isPlaying) {
          _playerModule.stopPlayer();
        }
        print('===>  准备开始播放');
        if (callBack != null) {
          callBack(199, "开始播放");
        }
        await _playerModule.startPlayer(
            fromURI: path,
            codec: Codec.aacADTS,
            sampleRate: 44000,
            whenFinished: () {
              if (callBack != null) {
                callBack(200, "播放完毕");
              }
            });
      }
      //监听播放进度
      _playerModule.onProgress!.listen((e) {
        print(" 播放 进度 $e");
      });
    } catch (err) {
      if (callBack != null) {
        callBack(0, "播放出错了");
      }
    }
  }

  /// 判断文件是否存在
  Future _fileExists(String path) async {
    return await File(path).exists();
  }

  ///销毁
  void disposePlayer() {
    _playerModule.closePlayer();
  }
}
