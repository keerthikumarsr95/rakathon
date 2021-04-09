import 'package:flutter/foundation.dart';
import 'package:momt/audio/audioManager.dart';
import 'package:momt/conversation/messages.dart';
import 'package:momt/conversation/enums.dart';
import 'package:momt/speech/SpeechToText.dart';
import 'package:momt/speech/textToSpeech.dart';

class ConversationManager {
  static final ConversationManager _singleton =
      new ConversationManager._internal();

  ConversationManager._internal();

  static ConversationManager get instance => _singleton;

  // late AudioManager audioManager;
  TextToSpeechManager ttSManager = TextToSpeechManager.instance;
  SpeechToTextManager stTManager = SpeechToTextManager.instance;
  AudioManager audioManager = new AudioManager();

  greetUser(String user) async {
    String welcomeMessage = messages['WELCOME_MESSAGE']?[1] ?? "Welcome";
    welcomeMessage = welcomeMessage.replaceAll('__USER__', user);
    print("momt welcomeMessage $welcomeMessage");
    await ttSManager.speak(welcomeMessage);
    String welcomeFupMessage = messages['WELCOME_FOLLOWUP']?[1];
    print("momt welcomeFupMessage $welcomeFupMessage");
    await ttSManager.speak(welcomeFupMessage);
  }

  speakMoodMessage(mood) async {
    String moodMessage = messages['MOOD_MESSAGES']?[mood];
    print("momt moodMessage $moodMessage");
    await ttSManager.speak(moodMessage);
  }

  speakActivityMessage(Activity activity) async {
    String moodMessage =
        messages['ACTIVITY_FOLLOWUP_MESSAGES']?[activity][Status.success];
    await ttSManager.speak(moodMessage);
  }

  speakActivityMoodMessage(user, Activity activity, Mood mood) async {
    String moodMessage = messages['ACTIVITY_MESSAGES']?[activity][mood];
    moodMessage = moodMessage.replaceAll('__USER__', user);
    await ttSManager.speak(moodMessage);
  }

  Future playMusic() async {
    await audioManager.load(2);
    await audioManager.play();
    await audioManager.awaitToComplete();
  }

  speakActivityCompletionMessage(Activity activity, Mood mood) async {
    String moodMessage = messages['ACTIVITY_COMPLETION']?[activity][mood];
    await ttSManager.speak(moodMessage);
  }

  Future startPreReadingStep(type, stepId) async {
    String moodMessage = messages['PRE_READING_MESSAGE']?[stepId];
    await ttSManager.speak(moodMessage);
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
    await ttSManager.speak(moodMessage);
    Map res = await getUserResponse(mainActivity);
    if (res['state'] == Status.success) {
      return runSteps(mainActivity, ['M_1', 'M_2', 'M_3'], 0);
    }
    //:TODO add failure flow
  }

  Future<String> listenToSpeech() async {
    await stTManager.listen();
    return Future.delayed(Duration(seconds: 3), () => stTManager.stop());
  }

  Map? processUserResponse(type, String? message) {
    print("user response message: $message, type: $type");
    switch (type) {
      case Activity.playMusic:
      case MainActivity.reading:
        {
          if (message == null) {
            return {'state': Status.success};
          }
          test(String value) => message.contains(value);
          var listS = messages['ACTIVITY_RESPONSE_KEYS']?[type][Status.success];

          if (listS.any(test)) return {'state': Status.success};

          var listF = messages['ACTIVITY_RESPONSE_KEYS']?[type][Status.failure];
          if (listF.any(test)) return {'state': Status.failure};
          return {'state': Status.success};
        }
        break;
      default:
        return null;
    }
  }

  Future getUserResponse(type) async {
    final message = await listenToSpeech();
    return processUserResponse(type, message);
  }

  Future runActivity(user, Activity activity, Mood mood) async {
    await speakActivityMessage(activity);
    await speakActivityMoodMessage(user, activity, mood);
    await playMusic();
    // await Future.delayed(Duration(seconds: 30));
    await speakActivityCompletionMessage(activity, mood);
  }

  runMainActivity2(MainActivity mainActivity, Subject subject, Topic topic) {}

  Future runMainActivity(
      user, MainActivity mainActivity, Subject subject, Topic topic) async {
    await runPreMainActivityMessage(user, mainActivity, subject, topic);
    // await runMainActivity2(user, mainActivity, subject, topic)
    print('At runMainActivity');
  }

  start() async {
    var user = "Keerthi";
    var mood = Mood.sorrow;
    var activity = Activity.playMusic;
    var mainActivity = MainActivity.reading;
    var subject = Subject.maths;
    var topic = Topic.numbers;

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
