import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';

class PlayerController extends GetxController {
  RxBool isPlaying = false.obs;
  RxInt playingIndex = 909990.obs;
  bool _isPaused = false;
  bool _isCompleted = false;
  playUrl(String url, int index) async {
    print(
        "1 was playing  $playingIndex and tapped is $index _isPaused $_isPaused");

    if (playingIndex == index) {
      playingIndex.value = index;
      print(
          "2 was playing  $playingIndex and tapped is $index  _isPaused $_isPaused");
      if (_isPaused) {
        await play();
        isPlaying.value = true;
      } else {
        await pause();
        isPlaying.value = false;
      }

      return;
    } else {
      playingIndex.value = index;
      print(
          "3 was playing  $playingIndex and tapped is $index  _isPaused $_isPaused");
      await MtnAudioPlayer.instance.playUrl(url, (player) {
        _playerState(player);
      });
      play();
    }
  }

  Future<void> play() async {
    await MtnAudioPlayer.instance.play();
    isPlaying.value = true;
    _isPaused = true;
  }

  Future<void> pause() async {
    _isPaused = true;

    print("paused tapped");
    await MtnAudioPlayer.instance.pause();
    isPlaying.value = false;
  }

  Future<void> resume() async {
    _isPaused = false;
    await MtnAudioPlayer.instance.resume();
  }

  Future<void> stop() async {
    await MtnAudioPlayer.instance.stop();
  }

  _playerState(AudioPlayer player) async {
    player.playerStateStream.listen((state) {
      if (state.playing) {
        _isPaused = false;
        switch (state.processingState) {
          case ProcessingState.idle:
            print("idle  =SKY==  ProcessingState.idle   ");
            break;
          case ProcessingState.loading:
            print("loading  =SKY==  ProcessingState.loading   ");
            break;
          case ProcessingState.buffering:
            print("buffering  =SKY==  ProcessingState.buffering   ");
            break;
          case ProcessingState.ready:
            print("ready  =SKY==  ProcessingState.ready   ");
            isPlaying.value = true;
            break;
          case ProcessingState.completed:
            print("completed  =SKY==  ProcessingState.completed   ");
            isPlaying.value = false;
            _isCompleted = true;
            break;
        }
      } else {
        _isPaused = true;
        isPlaying.value = false;
        print("Player is not playing is playing$isPlaying");
      }
    });
  }
}
