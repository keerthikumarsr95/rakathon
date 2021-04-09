import 'dart:async';

import 'package:emojis/emojis.dart';
import 'package:flutter/foundation.dart';
import 'package:momt/UI/ChatBot/BotUI.dart';
import 'package:momt/UI/ChatBot/StreamService.dart';
import 'package:momt/audio/audioManager.dart';
import 'package:momt/conversation/messages.dart';
import 'package:momt/conversation/enums.dart';
import 'package:momt/conversation/utils.dart';
import 'package:momt/speech/SpeechToText.dart';
import 'package:momt/speech/textToSpeech.dart';

class ConversationManager {
  static final ConversationManager _singleton =
      new ConversationManager._internal();

  ConversationManager._internal();

  static ConversationManager get instance => _singleton;

  // late AudioManager audioManager;

  StreamSink<ChatMessage> messageSink = StreamService.instance.stateSink;
  TextToSpeechManager ttSManager = TextToSpeechManager.instance;
  SpeechToTextManager stTManager = SpeechToTextManager.instance;
  AudioManager audioManager = new AudioManager();

  greetUser(String user) async {
    String welcomeMessage = messages['WELCOME_MESSAGE']?[1] ?? "Welcome";
    welcomeMessage = welcomeMessage.replaceAll('__USER__', user);
    welcomeMessage =
        welcomeMessage.replaceAll('__GREETING__', greetingMessage());
    print("momt welcomeMessage $welcomeMessage");
    messageSink.add(
        ChatMessage(messageContent: welcomeMessage, messageType: "sender"));
    await ttSManager.speak(welcomeMessage);
    String welcomeFupMessage = messages['WELCOME_FOLLOWUP']?[1];
    print("momt welcomeFupMessage $welcomeFupMessage");
    messageSink.add(
        ChatMessage(messageContent: welcomeFupMessage, messageType: "sender"));
    await ttSManager.speak(welcomeFupMessage);
  }

  speakMoodMessage(mood) async {
    String moodMessage = messages['MOOD_MESSAGES']?[mood];
    print("momt moodMessage $moodMessage");
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    await ttSManager.speak(moodMessage);
  }

  speakActivityMessage(Activity activity) async {
    String moodMessage =
        messages['ACTIVITY_FOLLOWUP_MESSAGES']?[activity][Status.success];
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    await ttSManager.speak(moodMessage);
  }

  speakActivityMoodMessage(user, Activity activity, Mood mood) async {
    String moodMessage = messages['ACTIVITY_MESSAGES']?[activity][mood];
    moodMessage = moodMessage.replaceAll('__USER__', user);
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    await ttSManager.speak(moodMessage);
  }

  Future playMusic() async {
    int audioId = 2;
    String moodMessage =
        "${Emojis.musicalNotes} Baby Shark Dance ${Emojis.musicalNotes}";
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    messageSink.add(ChatMessage(
        messageContent: "",
        messageType: "sender",
        mediaType: MediaType.audio,
        mediaLink: "assets/audios/audio_$audioId.mp3"));
    // await audioManager.load(audioId);
    // await audioManager.play();
    // await audioManager.awaitToComplete();
  }

  speakActivityCompletionMessage(Activity activity, Mood mood) async {
    String moodMessage = messages['ACTIVITY_COMPLETION']?[activity][mood];
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    await ttSManager.speak(moodMessage);
  }

  Future startPreReadingStep(type, stepId) async {
    String moodMessage = messages['PRE_READING_MESSAGE']?[stepId];
    await ttSManager.speak(moodMessage);
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    return getUserResponse(type);
  }

  runSteps(mainActivity, steps, index) async {
    if (steps.length == index) {
      return true;
    }
    var res = await startPreReadingStep(mainActivity, steps[index]);
    if (res['state'] == Status.success) {
      return runSteps(mainActivity, steps, index + 1);
    }
    return false;
  }

  runPreMainActivityMessage(
      user, MainActivity mainActivity, Subject subject, Topic topic) async {
    String moodMessage = messages['MAIN_ACTIVITY']?[MainActivity.reading];
    moodMessage = moodMessage.replaceAll('__USER__', user);
    moodMessage = moodMessage.replaceAll('__SUBJECT__', describeEnum(subject));
    moodMessage = moodMessage.replaceAll('__TOPIC__', describeEnum(topic));
    messageSink
        .add(ChatMessage(messageContent: moodMessage, messageType: "sender"));
    await ttSManager.speak(moodMessage);
    Map res = await getUserResponse(mainActivity);
    if (res['state'] == Status.success) {
      return runSteps(mainActivity, ['M_1', 'M_2', 'M_3'], 0);
    }
    //:TODO add failure flow
  }

  Future<String> listenToSpeech(timeOut) async {
    await stTManager.listen(timeOut);
    return Future.delayed(Duration(seconds: 3), () => stTManager.stop());
  }

  Map? processUserResponse(type, String? message, Map? ques) {
    print("user response message: $message, type: $type");
    switch (type) {
      case Activity.playMusic:
      case MainActivity.reading:
        {
          if (message == null) {
            return {'state': Status.success};
          }
          messageSink.add(
              ChatMessage(messageContent: message, messageType: "receiver"));
          test(String value) => message.contains(value);
          var listS = messages['ACTIVITY_RESPONSE_KEYS']?[type][Status.success];

          if (listS.any(test)) return {'state': Status.success};

          var listF = messages['ACTIVITY_RESPONSE_KEYS']?[type][Status.failure];
          if (listF.any(test)) return {'state': Status.failure};
          return {'state': Status.success};
        }
        break;
      case Activity.questions:
        {
          if (message?.isEmpty == true || message == null) {
            return {'state': Status.success};
          }
          return message?.contains(ques?['ANS'] ?? '') == true
              ? {'state': Status.success}
              : {'state': Status.failure};
        }
        break;
      default:
        return null;
    }
  }

  Future getUserResponse(type, {timeOut = 5, Map? ques}) async {
    final message = await listenToSpeech(timeOut ?? 5);
    return processUserResponse(type, message, ques);
  }

  Future runActivity(user, Activity activity, Mood mood) async {
    await speakActivityMessage(activity);
    await speakActivityMoodMessage(user, activity, mood);
    await playMusic();
    // await Future.delayed(Duration(seconds: 30));
    await speakActivityCompletionMessage(activity, mood);
  }

  Future presentQ(user, ques, index) async {
    ques['PRE_Q'].forEach((element) {
      messageSink
          .add(ChatMessage(messageContent: element, messageType: "sender"));
    });
    ques['PRO_Q'].forEach((element) {
      messageSink
          .add(ChatMessage(messageContent: element, messageType: "sender"));
    });
    ques['ASSET_LINK'].forEach((element) {
      messageSink.add(ChatMessage(
          messageContent: "",
          mediaType: MediaType.image,
          messageType: "sender",
          mediaLink: element));
    });
    await ttSManager.speak("Exercise $index");
    await ttSManager.speak("What is the result of addition?");
    return getUserResponse(Activity.questions);
  }

  Future speakMessageAndGetRes(message) async {
    messageSink
        .add(ChatMessage(messageContent: message, messageType: "sender"));
    await ttSManager.speak(message);
    return getUserResponse(Activity.playMusic);
  }

  Future speakMessage(message) async {
    messageSink
        .add(ChatMessage(messageContent: message, messageType: "sender"));
    await ttSManager.speak(message);
  }

  Future runActivity2(activity) async {
    var res = await speakMessageAndGetRes(activity['SNACKS_1']);
    messageSink.add(ChatMessage(
        messageContent: "",
        messageType: "sender",
        mediaType: MediaType.image,
        mediaLink: "assets/images/s_1.png"));
    if (res['state'] == Status.success) {
      var res = await speakMessageAndGetRes(activity['SNACKS_2']);
      if (res['state'] == Status.success) {
        var res = await speakMessageAndGetRes(activity['SNACKS_3']);
        if (res['state'] == Status.success) {
          return true;
        }
      }
    }
    return false;
  }

  runClosingActivity(user, activity) async {
    messageSink.add(ChatMessage(
        messageContent: "",
        messageType: "sender",
        mediaType: MediaType.image,
        mediaLink: "assets/images/s_2.png"));
    await speakMessage(activity['M_1']);
    messageSink.add(
        ChatMessage(messageContent: "", messageType: "sender", isExit: true));
    await speakMessage(activity['M_2']);
  }

  runMainActivity2(
      user, MainActivity mainActivity, Subject subject, Topic topic) async {
    var questions = messages['MATHS_QUESTION'];
    var res = await presentQ(user, questions?['Q_1'], 1);
    var res2 = await presentQ(user, questions?['Q_2'], 2);
    await runActivity2(messages['ACTIVITY_MESSAGE_EMP']);
    var res3 = await presentQ(user, questions?['Q_3'], 3);
    await runClosingActivity(user, messages['CLOSING']);
  }

  Future runMainActivity(
      user, MainActivity mainActivity, Subject subject, Topic topic) async {
    await runPreMainActivityMessage(user, mainActivity, subject, topic);
    await runMainActivity2(user, mainActivity, subject, topic);
    print('At runMainActivity');
  }

  start() async {
    var user = "Keerthi";
    var mood = Mood.sorrow;
    var activity = Activity.playMusic;
    var mainActivity = MainActivity.reading;
    var subject = Subject.maths;
    var topic = Topic.numbers;
    messageSink
        .add(ChatMessage(messageContent: "OOh hoo", messageType: "sender"));
    messageSink
        .add(ChatMessage(messageContent: "Yaa", messageType: "receiver"));
    await greetUser(user);
    await speakMoodMessage(mood);
    Map res = await getUserResponse(activity);
    if (res['state'] == Status.success) {
      //:TODO switch to NextScreen
      await runActivity(user, activity, mood);
      runMainActivity(user, mainActivity, subject, topic);
    }
  }
}
