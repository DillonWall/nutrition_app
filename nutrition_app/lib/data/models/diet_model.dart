class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool isAltBoxColor;
  bool viewIsSelected;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.isAltBoxColor,
    required this.viewIsSelected,
  });

  static List<DietModel> getDiets() {
    List<DietModel> diets = [];

    diets.add(DietModel(
      name: 'Honey Pancake',
      iconPath: 'assets/icons/honey-pancakes.svg',
      level: 'Easy',
      duration: '30mins',
      calorie: '180kCal',
      viewIsSelected: true,
      isAltBoxColor: false,
    ));

    diets.add(DietModel(
      name: 'Canai Bread',
      iconPath: 'assets/icons/canai-bread.svg',
      level: 'Easy',
      duration: '20mins',
      calorie: '230kCal',
      viewIsSelected: false,
      isAltBoxColor: true,
    ));

    return diets;
  }
}