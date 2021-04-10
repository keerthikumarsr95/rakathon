import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

class AudioManager {
  late AssetsAudioPlayer assetsAudioPlayer;
  Duration? audDuration;

  AudioManager() {
    assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  }

  Future load(id) async {
    audDuration = Duration(seconds: 136);
    var audio = Audio("assets/audios/audio_$id.mp3");
    print("audio $audio");
    await assetsAudioPlayer.open(
        Playlist(audios: [Audio("assets/audios/audio_$id.mp3")]),
        autoStart: false,
        forceOpen: true);
  }

  pause() async {
    await assetsAudioPlayer.pause();
  }

  Future play() async {
    // await assetsAudioPlayer.playOrPause();
    await assetsAudioPlayer.play();
    await assetsAudioPlayer.current.first
        .then((value) => audDuration = value?.audio.duration);
  }

  stop() {
    assetsAudioPlayer.stop();
  }

  listenToComplete(callback) {
    assetsAudioPlayer.playlistFinished.listen(callback);
  }

  Future awaitToComplete() async {
    Completer c = new Completer();
    print("audDuration ${audDuration?.inSeconds}");
    var audSeconds = audDuration?.inSeconds ?? 0;
    assetsAudioPlayer.currentPosition.listen((Duration state) {
      print("playlistFinished State ${state.inSeconds}");
      print("playlistFinished c.isCompleted ${c.isCompleted}");

      if (state.inSeconds == (audSeconds - 1) && !c.isCompleted)
        c.complete(state);
    });
    return c.future;
  }
}
