import 'dart:core';

class outcomeClass {
  List<String> snakes = [
    "Banded Krait",
    "Common Krait",
    "Common Sand Boa",
    "Green Pit Viper",
    "Green Vine Snake",
    "Hump Nosed Viper",
    "Indian Cobra",
    "Indian Rock Python",
    "Rat Snake",
    "Russell's Viper",
    "Saw Scaled Viper",
    "Sri Lanka Cat Snake",
  ];
  List<String> spiders = [];
  List<String> insects = [];

  String snakeClass(int predictNumber) {
    return snakes[predictNumber];
  }

  String spiderClass(int predictNumber) {
    return spiders[predictNumber];
  }

  String insectClass(int predictNumber) {
    return insects[predictNumber];
  }
}
