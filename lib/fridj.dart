import 'package:fridjapp_flutter/main.dart';
import 'package:json_annotation/json_annotation.dart';

enum Unit {
  g, kg, unit;
}

@JsonSerializable()
class Qtty {
  Qtty({
    required this.value,
    required this.u});

  int value;
  Unit u;
}

@JsonSerializable()
class Ingredient {
  Ingredient({
    required this.name,
    required this.qtty});

  String name;
  Qtty qtty;
}

@JsonSerializable()
class Fridj {
  Fridj();

  List<Ingredient> ingredients = List.empty(growable: true);
}