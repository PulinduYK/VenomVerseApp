import 'dart:core';

class outcomeClass {
  List<String> snakes = ["Banded Krait"];
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
