import 'dart:async';

import 'package:flutter/material.dart';
import 'package:momt/UI/ChatBot/StreamService.dart';
import 'package:momt/conversation/conversationManager.dart';
import 'package:momt/conversation/enums.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  MediaType mediaType;
  String? mediaLink;
  bool? isExit;

  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      this.mediaType: MediaType.text,
      this.mediaLink,
      this.isExit});
}

class ConversationalBot extends StatefulWidget {
  @override
  _ConversationalBotState createState() => _ConversationalBotState();
}

class _ConversationalBotState extends State<ConversationalBot> {
  List<ChatMessage> messages = [];

  StreamService streamService = StreamService.instance;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamSub = streamService.stateStream.listen((event) {
      setState(() {
        messages.add(event);
      });
    });
    Future.delayed(
        Duration(seconds: 5), () => ConversationManager.instance.start());
  }

  late StreamSubscription streamSub;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      ListView.builder(
        itemCount: messages.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (messages[index].messageType == "receiver"
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (messages[index].messageType == "receiver"
                      ? Colors.grey.shade200
                      : Colors.blue[200]),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  messages[index].messageContent,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          );
        },
      ),
    ]));
  }
}
