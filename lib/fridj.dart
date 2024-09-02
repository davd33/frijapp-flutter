import 'dart:collection';

enum Unit {
  g, kg, unit;
}

class Ingredient {
  late int id;
  String name;
  int qtty;
  Unit unit;

  Ingredient({
    required this.name,
    required this.qtty,
    required this.unit});

  Map<String, Object?> toMap() =>
      {'id': id,
        'name': name,
        'qtty': qtty,
        'unit': unit};
}

class Fridj {
  // uniq from server
  late String id;
  List<Ingredient> ingredients = List.empty(growable: true);
  List<Ingredient> shoppingList = List.empty(growable: true);
  Set<String> subscribed = Set.identity();
  String owner;

  Fridj({required this.owner});

  Map<String, Object?> toMap() =>
      {'id': id,
        'ingredients': ingredients};
}