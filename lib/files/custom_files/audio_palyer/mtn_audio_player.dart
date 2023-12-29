import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';

enum PlayerAction {
  started,
  stopped,
  paused,
}

class MtnAudioPlayer {
  static final MtnAudioPlayer instance = MtnAudioPlayer._internal();
  late AudioPlayer _player;
  MtnAudioPlayer._internal() {
    print("initialize MtnAudioPlayer");
    _player = AudioPlayer();
  }
  factory MtnAudioPlayer() {
    return instance;
  }

  Future<void> playUrl(
      String url, Function(AudioPlayer player) action, Function() error) async {
    print("playing url is $url");
    action(_player);
    await stop();
    try {
      await _player.setUrl(url);
    } on PlayerException catch (e) {
      error();
      print("SKY Error code: ${e.code}");
      print("SKY Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      error();
      print("SKY Connection aborted: ${e.message}");
    } catch (e) {
      error();
      print('SKY An error occured: $e');
    }
  }

  playerSeek(Duration position) async {
    _player.seek(position);
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

  playByte(Uint8List _buffer, Function(PlayerAction) action,
      Function(int, double) dura) async {
    print("Play this1");
    await _player.setAudioSource(MyJABytesSource(_buffer));
    print("Play this2");
    _player.play();
    print("Play this3");
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.ready) {
        action(PlayerAction.paused);
      } else if (state == ProcessingState.completed) {
        // What to do when it completes.
        action(PlayerAction.stopped);
      }
    });

    _player.positionStream.listen((Duration position) {
      var duration = _player.duration?.inSeconds ?? 0;
      var progress = (position.inSeconds / duration) * 100;
      dura(duration, progress);
      //action(null, position);
      // var currentSeekingStr =
      //     '${position.inSeconds > 9 ? "00:${position.inSeconds}" : "00:0${position.inSeconds}"}';
      // ;
      // print("max === ${currentSeekingStr}");
      // var maxDurationStr =
      //     '${player.duration!.inSeconds > 9 ? "00:${player.duration!.inSeconds}" : "00:0${player.duration!.inSeconds}"}';
      // print("max === ${maxDurationStr}");
    });
  }
}

class MyJABytesSource extends StreamAudioSource {
  final Uint8List _buffer;

  MyJABytesSource(this._buffer) : super(tag: 'MyAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: _buffer.length,
      contentLength: (start ?? 0) - (end ?? _buffer.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([_buffer.sublist(start ?? 0, end)]),
      contentType: 'audio/wav',
    );
  }
}
