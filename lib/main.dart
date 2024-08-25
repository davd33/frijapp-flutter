import 'package:flutter/material.dart';
import 'package:fridjapp_flutter/fridj.dart';

void main() {
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
      f.ingredients.add(Ingredient(name: "test", qtty: Qtty(value: 12, u: Unity.g)));
    });
  }

  Widget _displayFridj(Fridj f) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(children: f.ingredients.map((i) => Text(i.name)).toList()),
              TextButton(onPressed: () => _addIngredient(f), child: const Text("Add Ingredient")),
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
