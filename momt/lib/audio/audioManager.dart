import 'package:assets_audio_player/assets_audio_player.dart';

class AudioManager {
  late AssetsAudioPlayer assetsAudioPlayer;

  AudioManager() {
    assetsAudioPlayer = AssetsAudioPlayer();
  }

  load(id) {
    assetsAudioPlayer.open(Audio("assets/audios/audio_1.mp3"),
        autoStart: false);
  }

  pause() {
    assetsAudioPlayer.pause();
  }

  play() {
    assetsAudioPlayer.play();
  }

  stop() {
    assetsAudioPlayer.stop();
  }

  listenToComplete(callback) {
    assetsAudioPlayer.playlistFinished.listen(callback);
  }
}
