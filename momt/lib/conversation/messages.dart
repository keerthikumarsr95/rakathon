import 'package:momt/conversation/enums.dart';
import 'package:emojis/emojis.dart';

Map<String, Map> messages = {
  'WELCOME_MESSAGE': {1: "Hi __USER__. Good __GREETING__"},
  'WELCOME_FOLLOWUP': {
    1: "MOM-T was missing you all this while. Welcome back…!!!"
  },
  'MOOD_MESSAGES': {
    Mood.sorrow:
        "Why So Sad${Emojis.sadButRelievedFace}? Lets Dancing${Emojis.manDancing}?",
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
          'MOM-T Knows __USER__ enjoys Baby Shark Dance. Lets Dance Along...'
    },
  },
  'ACTIVITY_COMPLETION': {
    Activity.playMusic: {Mood.sorrow: "MOM-T Loved you Moooves"}
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
  },
  'MATHS_QUESTION': {
    'Q_1': {
      'PRE_Q': ["Exercise 1:"],
      'PRO_Q': ["5+2 =? got an answer?", "write a answer in the notebook."],
      'ASSET_LINK': ["assets/images/q1.png"],
      'ANS': "7",
      'SUCCESS': 'good job. next exercise',
      'FAILURE"': "No __USER__, Try one more time"
    },
    'Q_2': {
      'PRE_Q': ["Exercise 2:"],
      'PRO_Q': ["2+2 =?"],
      'ASSET_LINK': ["assets/images/q2.png"],
      'ANS': "4",
      'SUCCESS': 'good. next Exercise',
      "FAILURE": "No __USER__, Try one more time"
    },
    'Q_3': {
      'PRE_Q': ["Exercise 3:", "choose the correct answer."],
      'PRO_Q': [],
      'ASSET_LINK': [
        "assets/images/q3.png",
        "assets/images/q4.png",
        "assets/images/q5.png"
      ],
      'ANS': "4",
      'SUCCESS': 'Correct Answer __USER__. well done',
      "FAILURE": "No __USER__, Try one more time"
    },
  },
  "ACTIVITY_MESSAGE_EMP": {
    "SNACKS_1":
        "Before we proceed, I can see it's\nalso your evening snacks time.\nmom has kept cut fruits in the\nfridge for you to have.  go and\ntake it.",
    "SNACKS_2": "Let me know once you are back.",
    "SNACKS_3": "Great, Let's get started then. ",
  },
  'CLOSING': {
    "M_1": "collect your star medal.",
    "M_2": "See you tomorrow, bye! good night."
  },
};
