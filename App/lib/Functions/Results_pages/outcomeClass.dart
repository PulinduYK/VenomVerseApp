import 'dart:core';

class outcomeClass {
  List<String> snakes = [
    "Banded Krait",
    "Common Krait",
    "Common Sand Boa",
    "Green Pit Viper",
    "Green Vine Snake",
    "Hump-nosed Viper",
    "Indian Cobra",
    "Indian Rock Python",
    "Rat Snake",
    "Russell's Viper",
    "Saw Scaled Viper",
    "Sri Lanka Cat Snake",
  ];
  List<String> spiders = [
    "Adanson's House Jumper",
    "Black Widow",
    "Common Garden Spider",
    "Giant Golden Spider",
    "Gray Wall Jumping Spider",
    "Green Lynx Spider",
    "Heavy-bodied Jumping Spider",
    "Humped Orb-Weaver",
    "Oriental Spiny Orb-Weaver",
    "Pantropical Huntsman Spider",
    "Pantropical Jumping Spider",
    "Red Weaver Ant-mimicking Spider",
    "Sri Lankan Ornamental Tarantula",
    "Two-striped Telamonia",
  ];
  List<String> insects = [
    "Common Mormon",
    "Crimson Rose",
    "Giant Centipede",
    "Hottentotta tamulus",
    "Lime Butterfly",
    "Mud Dauber Wasp",
    "Red Weaver Ant",
    "Scutigera coleoptrata",
  ];

  String venomClass(int modelNumber, int classNumber) {
    if (modelNumber == 1) {
      return snakes[classNumber];
    }
    if (modelNumber == 2) {
      return spiders[classNumber];
    }
    if (modelNumber == 3) {
      return insects[classNumber];
    }
    return "Not Found model Number";
  }
}
