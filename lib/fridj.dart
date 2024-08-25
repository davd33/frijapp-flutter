import 'package:fridjapp_flutter/main.dart';

enum Unity {
  g, kg, unit;
}

class Qtty {
  Qtty({
    required this.value,
    required this.u});

  int value;
  Unity u;
}

class Ingredient {
  Ingredient({
    required this.name,
    required this.qtty});

  String name;
  Qtty qtty;
}

class Fridj {
  Fridj();

  List<Ingredient> ingredients = List.empty(growable: true);
}