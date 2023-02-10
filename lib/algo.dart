import 'dart:io';
import 'dart:math';

void main () {
  List<Activity> listActivity= [
    Activity(activityName: "horse"),
    Activity(activityName: "race")];
  Set<Map<String, dynamic>> moodMap = {};
  int sorter = 0;
  List<int> moodComparator = [];
  List<int> moodTracker = [];
  String? mood = "0";
  bool loop = true;
  int moodDifference = 0;
  String message = "";

  List<int> comparingPreviousMoods(int){
    if(moodComparator.length >= 2) {
      for (var i = moodComparator.lastIndexOf(moodComparator.last)-1; i < moodComparator.lastIndexOf(moodComparator.last); i++) {
        moodDifference = moodComparator[i+1] - moodComparator[i];
        if (moodDifference > 0) {
          print("Improvement");
          moodTracker.add(moodDifference);
        } else {
          if (moodDifference == 0) {
            print("Stabilisation");
            moodTracker.add(moodDifference);
          } else {
            print("Deterioration");
            moodTracker.add(moodDifference);
          }
        }
      }
    }
    print(moodTracker);
    return moodTracker;
  }
  void moodOperations(String, int){
    if(moodComparator.length >= 7){
      if ((moodComparator.elementAt(moodComparator.length - 6) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 5) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 4) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 3) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 2) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 1) < 2)) {
        print(
            "your mood wasn't very good the last 7 inputs, maybe you should go look for contacts:");
      }
    } else {
    if(moodComparator.length >= 4 && moodTracker.length >=3) {
      var rng = new Random();
      sorter = rng.nextInt(listActivity.length);
      if ((moodComparator.elementAt(moodComparator.length - 3) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 2) < 2) &&
          (moodComparator.elementAt(moodComparator.length - 1) < 2)) {
        message = listActivity.elementAt(sorter).getActivityName();
        print(
            "we saw that your mood wasn't very good in the last 3 inputs, we suggest that you do this activity: $message");
      } else {
        if ((moodTracker.elementAt(moodTracker.length - 3) < 0) &&
            (moodTracker.elementAt(moodTracker.length - 2) < 0) &&
            (moodTracker.elementAt(moodTracker.length - 1)) < 0) {
          message = listActivity.elementAt(sorter).getActivityName();
          print(
              "we saw that your mood deteriorated in the last 3 inputs, we suggest that you do this activity: $message");
              }
          }
        }
    }
  }

  void askingMood(int moodNumber, List<Map<String, dynamic>> moodList){
    var comparator = [];
    for(var n in moodList) {

      comparator.add(n.entries.first.value);
    }
    if(comparator.contains(moodNumber)){
      moodComparator.add(moodNumber);
      print(moodComparator);
    } else {
      print("No entry found, Please put a number between 0 and 4");
    }
    comparingPreviousMoods(moodComparator);
    moodOperations(moodTracker, moodComparator);
  }

  /* We create our different moods, and we are assigning a value to it: 0 is Not Good At All, 1 is Not Good etc...
  * In future versions, we could implement more than 5 moods, we could even substitute the current system with a
  * scroll bar for example, to make the app more precise. We decide for the MVP (Minimum Valuable Product) that a
  * point system would be more realistic for our goals. */
  moodMap = {
    const Mood(id: 0, currentMood: "Not Good At All").toMap(),
    const Mood(id: 1, currentMood: "Not Good").toMap(),
    const Mood(id: 2, currentMood: "Neutral").toMap(),
    const Mood(id: 3, currentMood: "Good").toMap(),
    const Mood(id: 4, currentMood: "Very Good").toMap()};

  /* We print the values of our map to the user, to let them know what to put on the screen */
  for (var n in moodMap) {
     print(n.values.toString());
  }
  while(loop) {
    print("Please insert your mood (number between 0 and 4): ");
    mood = stdin.readLineSync();
    if (mood != null){
      if (int.tryParse(mood) != null) {
        int moodNumber = int.parse(mood);
        print("Your current mood is: ${moodMap.elementAt(moodNumber).values.last}");
        var moodList = moodMap.toList();
        askingMood(moodNumber, moodList);
      }
    }
  }
}

/* Mood class, defined by its id and the current mood */
class Mood {
  final int id;
  final String currentMood;

  const Mood({
    required this.id,
    required this.currentMood,
  });


  String getCurrentMood(){
    return currentMood;
  }

  int getId(){
    return id;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mood': currentMood,
    };
  }
}

/* Activity class, defined by a name. This activity will be useful after the
 user inputs their mood, when 3 inputs in a row, their mood hasn't been well.  */
class Activity {
  final String activityName;

  const Activity({
    required this.activityName,
  });


  String getActivityName() {
    return activityName;
  }

  Map<String, dynamic> toMap() {
    return {
      'mood': activityName,
    };
  }
}