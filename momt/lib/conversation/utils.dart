String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Morning';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Evening';
  } else {
    return 'Night';
  }
}
