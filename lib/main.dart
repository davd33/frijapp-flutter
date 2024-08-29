import 'package:flutter/material.dart';
import 'package:fridjapp_flutter/fridj.dart';
import 'package:fridjapp_flutter/repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

late FridjRepository fridjRepository;

void main() async {
  const String fridjsDbFileName = "fridjs.db";

  databaseFactory = databaseFactoryFfiWeb;
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await openDatabase(
    join(await getDatabasesPath(), fridjsDbFileName),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE fridj(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    version: 1,
  );

  fridjRepository = FridjRepository(db: db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fridj App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Fridj> fridjs = List.empty(growable: true);

  void _createFridj() {
    setState(() {
      fridjs.add(Fridj());
    });
  }

  void _addIngredient(Fridj f) {
    setState(() {
      f.ingredients.add(Ingredient(name: "...", qtty: 0, unit: Unit.g));
    });
  }

  Widget _displayFridj(Fridj f) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(children: f.ingredients.map((i) =>
                  IngredientField(ingredient: i,)).toList()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => _addIngredient(f),
                      child: const Text("Add Ingredient")),
                  TextButton(
                      onPressed: () {
                        fridjRepository.insertFridj(f);
                      },
                      child: Text('Save')),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: fridjs.map(_displayFridj).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createFridj,
        tooltip: 'Create Fridj',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class IngredientField extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientField({super.key, required this.ingredient});

  @override
  State<IngredientField> createState() => _IngredientFieldState();
}

class _IngredientFieldState extends State<IngredientField> {

  late TextEditingController qttyCtrl;

  @override
  initState() {
    super.initState();
    qttyCtrl = TextEditingController(text: "what qtty");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                onChanged: (String value) {
                  setState(() {
                    widget.ingredient.name = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                controller: qttyCtrl,
                onChanged: (String value) {
                  setState(() {
                    int? iVal = int.tryParse(value);
                    if (iVal != null) {
                      widget.ingredient.qtty = iVal;
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 10,),
            DropdownMenu<Unit>(
              initialSelection: Unit.g,
              requestFocusOnTap: true,
              label: const Text("Unit"),
              onSelected: (value) {
                setState(() {
                  if (value != null) {
                    widget.ingredient.unit = value;
                  }
                });
              },
              dropdownMenuEntries: Unit.values.map<DropdownMenuEntry<Unit>>((u) =>
                  DropdownMenuEntry(value: u, label: u.name))
                  .toList(),),
          ],
        ),
        const SizedBox(height: 30,)
      ],
    );
  }
}

