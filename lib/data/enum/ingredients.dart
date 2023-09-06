enum IngredientsType {
  bread,
  drink,
  spices,
  proteinsFats,
  groats,
  freshVegetables,
  driedVegetables,
  sweets,
  cookies,
  driedFruits,
  candy,
  candiedFruit,
  nuts,
}

extension IngredientsTypeExtension on IngredientsType {
  String get name {
    switch (this) {
      case IngredientsType.bread:
        return 'Хлібобулочні вироби';
      case IngredientsType.drink:
        return 'Напої';
      case IngredientsType.spices:
        return 'Спеції';
      case IngredientsType.proteinsFats:
        return 'Білки та жири';
      case IngredientsType.groats:
        return 'Крупи';
      case IngredientsType.freshVegetables:
        return 'Свіжі овочі';
      case IngredientsType.driedVegetables:
        return 'Сушені овочі';
      case IngredientsType.sweets:
        return 'Солодощі';
      case IngredientsType.cookies:
        return 'Печиво';
      case IngredientsType.driedFruits:
        return 'Сухофрукти';
      case IngredientsType.candy:
        return 'Цукерки';
      case IngredientsType.candiedFruit:
        return 'Консервовані фрукти';
      case IngredientsType.nuts:
        return 'Горіхи';
      default:
        return 'Хлібобулочні вироби';
    }
  }

  int get index {
    switch (this) {
      case IngredientsType.bread:
        return 0;
      case IngredientsType.drink:
        return 1;
      case IngredientsType.spices:
        return 2;
      case IngredientsType.proteinsFats:
        return 3;
      case IngredientsType.groats:
        return 4;
      case IngredientsType.freshVegetables:
        return 5;
      case IngredientsType.driedVegetables:
        return 6;
      case IngredientsType.sweets:
        return 7;
      case IngredientsType.cookies:
        return 8;
      case IngredientsType.driedFruits:
        return 9;
      case IngredientsType.candy:
        return 10;
      case IngredientsType.candiedFruit:
        return 11;
      case IngredientsType.nuts:
        return 12;
      default:
        return 0;
    }
  }

  IngredientsType fromIndex(int index) {
    switch (index) {
      case 0:
        return IngredientsType.bread;
      case 1:
        return IngredientsType.drink;
      case 2:
        return IngredientsType.spices;
      case 3:
        return IngredientsType.proteinsFats;
      case 4:
        return IngredientsType.groats;
      case 5:
        return IngredientsType.freshVegetables;
      case 6:
        return IngredientsType.driedVegetables;
      case 7:
        return IngredientsType.sweets;
      case 8:
        return IngredientsType.cookies;
      case 9:
        return IngredientsType.driedFruits;
      case 10:
        return IngredientsType.candy;
      case 11:
        return IngredientsType.candiedFruit;
      case 12:
        return IngredientsType.nuts;
      default:
        return IngredientsType.bread;
    }
  }
}
