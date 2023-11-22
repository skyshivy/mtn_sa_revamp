import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

class PlayerController extends GetxController {
  RxBool isPlaying = false.obs;
  bool stopStatePring = true;
  RxInt playingIndex = 9999999.obs;
  RxBool isBuffering = false.obs;
  bool _isPaused = false;
  bool _isCompleted = false;
  RxString tuneName = ''.obs;
  RxString artistName = ''.obs;
  RxString tuneImage = ''.obs;
  RxInt current = 0.obs;
  RxInt maxDuration = 0.obs;
  RxString maxDurationStr = '00:00'.obs;
  RxString currentSeekingStr = '00:00'.obs;
  late TuneInfo? info;
  String toneId = '';
  playUrl(TuneInfo? info, int index) async {
    this.info = info;
    tuneName.value = info?.toneName ?? '';
    artistName.value = info?.artistName ?? '';
    tuneImage.value =
        info?.toneIdpreviewImageUrl ?? info?.previewImageUrl ?? '';
    printCustom(
        "1 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");

    if (toneId == (toneId = info?.toneId ?? '')) {
      playingIndex.value = index;
      toneId = info?.toneId ?? '';
      printCustom(
          "2 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");
      if (_isPaused) {
        await resume();
      } else {
        await pause();
      }
      printCustom("Is playing status $isPlaying");
      return;
    } else {
      playingIndex.value = index;
      toneId = info?.toneId ?? '';
      printCustom(
          "3 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying $isPlaying");
      isBuffering.value = true;
      await MtnAudioPlayer.instance.playUrl(info?.toneIdStreamingUrl ?? '',
          (player) {
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
    printCustom("paused tapped");
    isPlaying.value = false;
    await MtnAudioPlayer.instance.pause();
  }

  Future<void> playPause() async {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  Future<void> resume() async {
    _isPaused = false;
    isPlaying.value = true;
    await MtnAudioPlayer.instance.resume();
  }

  Future<void> stop() async {
    await MtnAudioPlayer.instance.stop();
    current.value = 0;
    toneId = '';
    playingIndex.value = -1;
    toneId = '';
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
              printCustom("idle  =SKY==  ProcessingState.idle   ");
            }

            break;
          case ProcessingState.loading:
            if (stopStatePring) {
              printCustom("loading  =SKY==  ProcessingState.loading   ");
              isBuffering.value = true;
            }
            break;
          case ProcessingState.buffering:
            if (stopStatePring) {
              printCustom("buffering  =SKY==  ProcessingState.buffering   ");
            }
            isBuffering.value = true;
            break;
          case ProcessingState.ready:
            if (stopStatePring) {
              printCustom("ready  =SKY==  ProcessingState.ready   ");
            }

            break;
          case ProcessingState.completed:
            if (stopStatePring) {
              printCustom("completed  =SKY==  ProcessingState.completed   ");
            }
            playingIndex.value = -1;
            toneId = '';
            isPlaying.value = false;
            _isCompleted = true;
            _isPaused = false;
            break;
        }
      } else {
        isPlaying.value = false;
        _isPaused = true;
        printCustom("Player is not playing");
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
        printCustom('SKY Error code: ${e.code}');
        printCustom('SKY Error message: ${e.message}');
      } else {
        printCustom('SKY An error occurred: $e');
      }
    });
  }
}


/*
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

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
    printCustom(
        "1 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");

    if (playingIndex.value == index) {
      playingIndex.value = index;
      printCustom(
          "2 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");
      if (_isPaused) {
        await resume();
      } else {
        await pause();
      }
      printCustom("Is playing status $isPlaying");
      return;
    } else {
      playingIndex.value = index;
      printCustom(
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
    printCustom("paused tapped");
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
              printCustom("idle  =SKY==  ProcessingState.idle   ");
            }

            break;
          case ProcessingState.loading:
            if (stopStatePring) {
              printCustom("loading  =SKY==  ProcessingState.loading   ");
            }
            break;
          case ProcessingState.buffering:
            if (stopStatePring) {
              printCustom("buffering  =SKY==  ProcessingState.buffering   ");
            }
            isBuffering.value = true;
            break;
          case ProcessingState.ready:
            if (stopStatePring) {
              printCustom("ready  =SKY==  ProcessingState.ready   ");
            }

            break;
          case ProcessingState.completed:
            if (stopStatePring) {
              printCustom("completed  =SKY==  ProcessingState.completed   ");
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
        printCustom("Player is not playing");
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
        printCustom('SKY Error code: ${e.code}');
        printCustom('SKY Error message: ${e.message}');
      } else {
        printCustom('SKY An error occurred: $e');
      }
    });
  }
}
*/