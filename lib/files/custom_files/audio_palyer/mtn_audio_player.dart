import 'package:just_audio/just_audio.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class MtnAudioPlayer {
  static final MtnAudioPlayer instance = MtnAudioPlayer._internal();
  late AudioPlayer _player;
  MtnAudioPlayer._internal() {
    printCustom("initialize MtnAudioPlayer");
    _player = AudioPlayer();
  }
  factory MtnAudioPlayer() {
    return instance;
  }

  Future<void> playUrl(
      String url, Function(AudioPlayer player) action, Function() error) async {
    printCustom("playing url is $url");
    action(_player);
    await stop();
    try {
      await _player.setUrl(url);
    } on PlayerException catch (e) {
      error();
      printCustom("SKY Error code: ${e.code}");
      printCustom("SKY Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      error();
      printCustom("SKY Connection aborted: ${e.message}");
    } catch (e) {
      error();
      printCustom('SKY An error occured: $e');
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
}
