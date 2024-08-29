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
  late int id;
  List<Ingredient> ingredients = List.empty(growable: true);

  Fridj();

  Map<String, Object?> toMap() =>
      {'id': id,
        'ingredients': ingredients};
}