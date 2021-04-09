import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TextToSpeechManager {
  static final TextToSpeechManager _singleton =
      new TextToSpeechManager._internal();

  TextToSpeechManager._internal() {
    _init();
  }

  static TextToSpeechManager get instance => _singleton;

  FlutterTts flutterTts = FlutterTts();
  TtsState ttlState = TtsState.stopped;

  // TextToSpeechManager()

  _init() async {
    // await flutterTts.setLanguage("en-IN");
    // await flutterTts.setSpeechRate(0.7);
    // await flutterTts.setPitch(1.0);
    print('Voices');
    print(await flutterTts.getVoices);
    // await flutterTts.awaitSpeakCompletion(true);
  }

  speak(String text) async {
    ttlState = TtsState.playing;
    final result = await flutterTts.speak(text);
    if (result == 1) ttlState = TtsState.stopped;
    await flutterTts.awaitSpeakCompletion(true);
  }

  stop() async {
    final result = await flutterTts.stop();
    if (result == 1) ttlState = TtsState.stopped;
  }
}
