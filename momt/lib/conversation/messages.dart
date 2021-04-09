import 'package:momt/conversation/enums.dart';

Map<String, Map> messages = {
  'WELCOME_MESSAGE': {1: "Hi __USER__"},
  'WELCOME_FOLLOWUP': {
    1: "MOM-T was missing you all this while. Welcome back…!!!"
  },
  'MOOD_MESSAGES': {
    Mood.sorrow: "Why So Sad? Lets Dancing?",
  },
  'ACTIVITY_FOLLOWUP_MESSAGES': {
    Activity.playMusic: {
      Status.success: "Put your Dance shoes on!!",
      Status.failure: "What else would you like?"
    },
  },
  'ACTIVITY_MESSAGES': {
    Activity.playMusic: {
      Mood.sorrow:
          'MoM-T Knows __USER__ enjoys Baby Shark Dance. Lets Dance Along...'
    },
  },
  'ACTIVITY_COMPLETION': {
    Activity.playMusic: {Mood.sorrow: "MoMT Loved you Moooves"}
  },
  'MAIN_ACTIVITY': {
    MainActivity.reading:
        "Hi __USER__! It's time to do some revision now. This will be your __SUBJECT__ __TOPIC__ class."
  },
  'PRE_READING_MESSAGE': {
    'M_1':
        "Before we proceed, I can see it's also your evening snacks time. Do you want to get some snacks for yourself?",
    'M_2': 'Let me know once you are back.',
    'M_3': "Great, Let's get started then.",
  },
  'MATHS_READING': {
    'ADDITION': {
      'Q_1': 'What is __NUM_1__ plus __NUM_2__?',
      'Q_2': '__NUM__ is read as?'
    },
  },
  'ANS_SUCCESS': {'A_1': "That's the right answer. Good Job!!"},
  'ANS_FAILURE': {'A_1': "That's the right answer. Good Job!!"},
  'ACTIVITY_RESPONSE_KEYS': {
    Activity.playMusic: {
      Status.success: ['yes', 'okay'],
      Status.failure: ['no', 'skip']
    },
    MainActivity.reading: {
      Status.success: ['yes', 'okay'],
      Status.failure: ['no']
    }
  }
};
