import 'dart:async';

import 'package:flutter/material.dart';
import 'package:momt/UI/ChatBot/StreamService.dart';
import 'package:momt/UI/pages/MusicPlayer.dart';
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
    streamService.stateStream.listen((event) {
      setState(() {
        messages.add(event);
      });
    });
    Future.delayed(
        Duration(seconds: 5), () => ConversationManager.instance.start());
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
                child: Message(index: index, msg: messages[index]),
              ),
            ),
          );
        },
      ),
    ]));
  }
}

class Message extends StatelessWidget {
  //const ProfileCard({Key? key}) : super(key: key);
  final int index;
  final ChatMessage msg;
  //String mediaPath = "";
  Message({required this.index, required this.msg}) {
    //this.mediaPath = this.msg.mediaLink.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (msg.mediaType == MediaType.image) {
      return Container(
          //padding: EdgeInsets.symmetric(vertical: 30),
          height: 50,
          width: 50,
          child: Image.asset(msg.mediaLink.toString()));
    } else if (msg.mediaType == MediaType.text) {
      return Text(
        msg.messageContent,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Colors.white,
            fontSize: 15.0),
      );
    } else if (msg.mediaType == MediaType.audio) {
      return MusicPlayer();
    }
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          new Container(
            height: 500,
            child: Image.asset(msg.mediaLink.toString()),
          )
        ]));
  }
}
