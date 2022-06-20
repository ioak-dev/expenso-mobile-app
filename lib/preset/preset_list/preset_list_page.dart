import 'package:endurance/preset/preset_list/preset_list.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PresetListPage extends StatefulWidget {
  const PresetListPage({Key? key}) : super(key: key);

  @override
  State<PresetListPage> createState() => _PresetListPageState();
}

class _PresetListPageState extends State<PresetListPage> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Widget Lifecycle: initState');
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890    ';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void openAddPage() {
    Navigator.pushNamed(context, '/preset/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preset list"),
        elevation: 0,
      ),
      body: Container(
          child: Column(
        children: [
          PresetList(),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openAddPage();
        },
        backgroundColor: Colors.grey,
      ),
    );
  }
}
