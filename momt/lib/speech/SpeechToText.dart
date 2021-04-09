import 'dart:async';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

enum SstState { listening, stopped }

class SpeechToTextManager {
  static final SpeechToTextManager _singleton =
      new SpeechToTextManager._internal();

  SpeechToTextManager._internal() {
    _init();
  }

  static SpeechToTextManager get instance => _singleton;

  stt.SpeechToText speech = stt.SpeechToText();
  SstState state = SstState.stopped;

  // SpeechToTextManager() {
  //   _init();
  // }

  _init() async {
    bool available = await speech.initialize(
        onStatus: _statusListener, onError: _errorListener);
    if (available == false) {
      print("The user has denied the use of speech recognition.");
    }
    print("******The user has accepted the use of speech recognition.********");
    print("is available ${speech.isAvailable}");
    // speech.listen( onResult: resultListener );
    // speech.stop()
  }

  _statusListener(String status) {
    print("stt status $status");
  }

  _errorListener(SpeechRecognitionError errorNotification) {
    print("stt error status $errorNotification");
  }

  _resultListener(SpeechRecognitionResult result) {
    print("SpeechRecognitionResult $result");
  }

  listen() async {
    var res = await speech.listen(onResult: _resultListener, listenFor: Duration(seconds: 5));
    print("sst listen res $res");

    state = SstState.listening;
  }

  FutureOr<String> stop() async {
    if (speech.isListening) await speech.stop();
    state = SstState.stopped;
    return speech.lastRecognizedWords;
  }
}
