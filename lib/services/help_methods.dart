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
