class AverageValue {
  List? achievementList;
  AverageValue(this.achievementList);

  double funcAchievementList(achievementList) {
    int j = 1;
    double sumList = 0;
    for (var i in achievementList) {
      sumList += i;
      j++;
    }
    return sumList / j;
  }
}
