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
  bool isStreaming = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Future _init() async {
    print("isStreaming 1 $isStreaming");
    if (isStreaming) {
      await streamSub.cancel();
      isStreaming = false;
    }
    print("isStreaming 2 $isStreaming");
    streamSub = streamService.stateStream.listen((event) {
      setState(() {
        messages.add(event);
      });
    });
    isStreaming = true;
    print("isStreaming 3 $isStreaming");
    Future.delayed(
        Duration(seconds: 1), () => ConversationManager.instance.start());
  }

  late StreamSubscription streamSub;

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    await streamSub.cancel();
    isStreaming = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "MomT",
            style: TextStyle(color: Colors.deepPurple, fontFamily: 'RakutenRg'),
          ),
          backgroundColor: Colors.deepPurple.shade100,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Container(
              width: 80.0,
              height: 80.0,
              child: new RawMaterialButton(
                elevation: 2.0,
                shape: new CircleBorder(),
                fillColor: Colors.deepPurple,
                child:
                    Image.asset('assets/images/momtBot.png', fit: BoxFit.fill),
                onPressed: () {
                  // navigateToProfile(context);
                },
              )),
        ),
        body: Stack(children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: (messages[index].messageType == "receiver"
                      //     ? Colors.grey.shade200
                      //     : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(12),
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
  final int index;
  final ChatMessage msg;

  Message({required this.index, required this.msg});

  @override
  Widget build(BuildContext context) {
    if (msg.mediaType == MediaType.image) {
      return Container(
          //padding: EdgeInsets.symmetric(vertical: 30),
          height: 120,
          width: 120,
          child: Image.asset(msg.mediaLink.toString()));
    } else if (msg.mediaType == MediaType.text) {
      return Text(
        msg.messageContent,
        style: TextStyle(
            fontFamily: 'RakutenRg',
            fontWeight: FontWeight.bold,
            color: msg.messageType == "receiver" ? Colors.black87 : Colors.pink,
            fontSize: 16.0),
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
