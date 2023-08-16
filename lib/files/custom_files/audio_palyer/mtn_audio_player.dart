import 'package:just_audio/just_audio.dart';

class MtnAudioPlayer {
  static final MtnAudioPlayer instance = MtnAudioPlayer._internal();
  late AudioPlayer _player;
  MtnAudioPlayer._internal() {
    print("initialize MtnAudioPlayer");
    _player = AudioPlayer();
    //_playerState();
  }
  factory MtnAudioPlayer() {
    return instance;
  }

  Future<void> playUrl(String url, Function(AudioPlayer player) action) async {
    print("playing url is ${url}");
    action(_player);
    await stop();
    await _player.setUrl(url);
    _player.setSpeed(10);
    //_player.play();
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> resume() async {
    await _player.play();
  }

  // _playerState() async {
  //   _player.playerStateStream.listen((state) {
  //     if (state.playing) {
  //       switch (state.processingState) {
  //         case ProcessingState.idle:
  //           print("idle  ===  ProcessingState.idle   ");
  //           break;
  //         case ProcessingState.loading:
  //           print("loading  ===  ProcessingState.loading   ");
  //           break;
  //         case ProcessingState.buffering:
  //           print("buffering  ===  ProcessingState.buffering   ");
  //           break;
  //         case ProcessingState.ready:
  //           print("ready  ===  ProcessingState.ready   ");
  //           break;
  //         case ProcessingState.completed:
  //           print("completed  ===  ProcessingState.completed   ");
  //           break;
  //       }
  //     } else {
  //       print("Player is not playing");
  //     }
  //   });
  // }
}
