class predictionOutcome {
  List<String> snakeNames = ["Banded Krait"];
  String numberToSnakeClass(number) {
    if (number != null) {
      return snakeNames[number];
    }
    return "System error";
  }
}
