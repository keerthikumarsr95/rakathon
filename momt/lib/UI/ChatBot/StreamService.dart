import 'dart:async';

import 'package:momt/UI/ChatBot/BotUI.dart';

class StreamService {

  static final StreamService _singleton =
  new StreamService._internal();

  StreamService._internal();

  static StreamService get instance => _singleton;

  StreamController<ChatMessage> controller = StreamController();

  Stream<ChatMessage> get stateStream => controller.stream;

  StreamSink<ChatMessage> get stateSink => controller.sink;
}
