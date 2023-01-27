import 'dart:io';
import 'dart:math';

void main () {
  List<Activity> listActivity= [Activity(activityName: "cheval"), Activity(activityName: "course")];
  Set<Map<String, dynamic>> moodMap = {};
  int sorter = 0;
  List<String> moodMessage = [];
  List<int> moodComparator = [];
  List<int> moodTracker = [];
  String? mood = "0";
  bool loop = true;
  int moodDifference = 0;
  String message = "";

  List<int> comparingPreviousMoods(int){
    if(moodComparator.length >= 2) {
      for (var i = 1; i < moodComparator.length; i++) {
        moodDifference = moodComparator[i] - moodComparator[i-1];
        if (moodDifference > 0) {
          print("Amélioration");
          moodTracker.add(moodDifference);
        } else {
          if (moodDifference == 0) {
            print("Stabilisation");
            moodTracker.add(moodDifference);
          } else {
            print("Dégradation");
            moodTracker.add(moodDifference);
          }
        }
      }
    }
    return moodTracker;
  }
  String moodOperations(String, int){
    if(moodTracker.length >= 3) {
      var rng = new Random();
      sorter = rng.nextInt(listActivity.length);
        for (var j in moodComparator) {
          if ((moodComparator.elementAt(moodComparator.length-1) < 2) && (moodComparator.elementAt(moodComparator.length-2) < 2) &&
              (moodComparator.elementAt(moodComparator.length-3)< 2)) {
            message = listActivity.elementAt(sorter).getActivityName();
            moodMessage.add(message);
          }
        }
        for (var i in moodTracker) {
          if ((moodTracker.elementAt(moodTracker.length-1) < 0) && (moodTracker.elementAt(moodTracker.length-2)< 0) &&
              (moodTracker.elementAt(moodTracker.length-3) < 0)) {

            message = listActivity.elementAt(sorter).getActivityName();
            moodMessage.add(message);
          }
        }
      }
    print(moodMessage);
    return message;
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

  moodMap = {const Mood(id: 0, currentMood: "Pas bien du tout").toMap(), const Mood(id: 1, currentMood: "Pas bien").toMap(), const Mood(id: 2, currentMood: "Neutre").toMap(), const Mood(id: 3, currentMood: "Bien").toMap(), const Mood(id: 4, currentMood: "Très bien").toMap()};
  for (var n in moodMap) {
     print(n.values.toString());
  }
  while(loop) {
    print("Entrer votre humeur:");
    mood = stdin.readLineSync();
    if (mood != null){
      if (int.tryParse(mood) != null) {
        int moodNumber = int.parse(mood);
        var moodList = moodMap.toList();
        askingMood(moodNumber, moodList);
      }
    }
  }
}

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