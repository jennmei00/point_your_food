double roundPoints(double points) {
  double result = 0;
  double decimalNumbers =
      double.tryParse('0.${points.toString().split(".").last}')!;

  if (decimalNumbers <= 0.24) {
    result = points.truncateToDouble();
  } else if (decimalNumbers <= 0.74) {
    result = double.tryParse('${points.truncate()}.5')!;
  } else {
    result = points.truncateToDouble() + 1;
  }

  return result;
}

int calculateDailypoints({
  required int gender,
  required int age,
  required double weight,
  required double height,
  required int move,
  required int purpose,
}) {
  int points = 0;

  //Male or Female
  if (gender == 0) {
    //male
    points += 15;
  } else {
    //female
    points += 7;
  }

  //Age
  if (age <= 20) {
    points += 5;
  } else if (age <= 35) {
    points += 4;
  } else if (age <= 50) {
    points += 3;
  } else if (age <= 65) {
    points += 2;
  } else {
    points += 1;
  }

  //Weight
  points += (weight / 10).truncate();

  //Height
  if (height < 1.60) {
    points += 1;
  } else {
    points += 2;
  }

  //Move
  if (move == 0) {
    //no move
    points += 0;
  } else if (move == 1) {
    //little move
    points += 2;
  } else if (move == 2) {
    //much move
    points += 4;
  } else if (move == 3) {
    //daily move
    points += 6;
  }

  //purpose
  if (purpose == 0) {
    //hold weight
    points += 4;
  } else {
    //reduce weight
    points += 0;
  }

  return points;
}
