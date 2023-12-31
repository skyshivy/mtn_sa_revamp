import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';

class PlayerController extends GetxController {
  RxBool isPlaying = false.obs;
  bool stopStatePring = true;
  RxInt playingIndex = 9999999.obs;
  RxBool isBuffering = false.obs;
  bool _isPaused = false;
  bool _isCompleted = false;

  RxInt current = 0.obs;
  RxInt maxDuration = 0.obs;
  RxString maxDurationStr = '00:00'.obs;
  RxString currentSeekingStr = '00:00'.obs;

  playUrl(String url, int index) async {
    print(
        "1 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");

    if (playingIndex.value == index) {
      playingIndex.value = index;
      print(
          "2 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");
      if (_isPaused) {
        await resume();
      } else {
        await pause();
      }
      print("Is playing status $isPlaying");
      return;
    } else {
      playingIndex.value = index;
      print(
          "3 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying $isPlaying");
      isBuffering.value = true;
      await MtnAudioPlayer.instance.playUrl(url, (player) {
        _playerState(player);
      }, () async {
        await stop();
        return;
      });

      await play();
    }
  }

  Future<void> play() async {
    isPlaying.value = true;
    _isPaused = false;
    await MtnAudioPlayer.instance.play();
  }

  Future<void> seekTo(Duration position) async {
    await MtnAudioPlayer.instance.playerSeek(position);
  }

  Future<void> pause() async {
    _isPaused = true;
    print("paused tapped");
    isPlaying.value = false;
    await MtnAudioPlayer.instance.pause();
  }

  Future<void> resume() async {
    _isPaused = false;
    isPlaying.value = true;
    await MtnAudioPlayer.instance.resume();
  }

  Future<void> stop() async {
    await MtnAudioPlayer.instance.stop();
    current.value = 0;
    playingIndex.value = -1;
    isPlaying.value = false;
    _isCompleted = true;
    _isPaused = false;
  }

  _playerState(AudioPlayer player) async {
    error(player);
    player.playerStateStream.listen((state) {
      isBuffering.value = false;
      if (state.playing) {
        switch (state.processingState) {
          case ProcessingState.idle:
            if (stopStatePring) {
              print("idle  =SKY==  ProcessingState.idle   ");
            }

            break;
          case ProcessingState.loading:
            if (stopStatePring) {
              print("loading  =SKY==  ProcessingState.loading   ");
            }
            break;
          case ProcessingState.buffering:
            if (stopStatePring) {
              print("buffering  =SKY==  ProcessingState.buffering   ");
            }
            isBuffering.value = true;
            break;
          case ProcessingState.ready:
            if (stopStatePring) {
              print("ready  =SKY==  ProcessingState.ready   ");
            }

            break;
          case ProcessingState.completed:
            if (stopStatePring) {
              print("completed  =SKY==  ProcessingState.completed   ");
            }
            playingIndex.value = -1;
            isPlaying.value = false;
            _isCompleted = true;
            _isPaused = false;
            break;
        }
      } else {
        isPlaying.value = false;
        _isPaused = true;
        print("Player is not playing");
      }
    });
    player.positionStream.listen((position) {
      currentSeekingStr.value = position.inSeconds > 9
          ? "00:${position.inSeconds}"
          : "00:0${position.inSeconds}";
      ;
      current.value = position.inSeconds;
      maxDuration.value = player.duration!.inSeconds;

      maxDurationStr.value = player.duration!.inSeconds > 9
          ? "00:${player.duration!.inSeconds}"
          : "00:0${player.duration!.inSeconds}";
    });
  }

  error(AudioPlayer player) {
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('SKY Error code: ${e.code}');
        print('SKY Error message: ${e.message}');
      } else {
        print('SKY An error occurred: $e');
      }
    });
  }
}
