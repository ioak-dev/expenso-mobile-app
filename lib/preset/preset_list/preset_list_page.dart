import 'package:endurance/preset/preset_list/preset_list.dart';
import 'package:endurance/shared/preset.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PresetListPage extends StatefulWidget {
  const PresetListPage({Key? key}) : super(key: key);

  @override
  State<PresetListPage> createState() => _PresetListPageState();
}

class _PresetListPageState extends State<PresetListPage> {
  List<Preset> _activities = [
    const Preset(id: 1, name: 'Test lorem', seconds: 10, order: 1),
    const Preset(id: 2, name: 'Dolor sit', seconds: 50, order: 2),
    const Preset(id: 3, name: 'Welcome to Rancher', seconds: 120, order: 3)
  ];

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
    setState(() {
      _activities = List.from(_activities)
        ..add(
          Preset(id: 1, name: getRandomString(20), seconds: 10, order: 1),
        );
    });
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
          PresetList(activities: _activities),
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
