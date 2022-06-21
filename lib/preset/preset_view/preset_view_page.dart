import 'dart:async';

import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetViewPage extends StatefulWidget {
  const PresetViewPage({Key? key}) : super(key: key);

  @override
  State<PresetViewPage> createState() => _PresetViewPageState();
}

class _PresetViewPageState extends State<PresetViewPage> {
  late PresetBloc presetBloc;
  late int id;
  Preset? preset;
  StreamSubscription? presetBlocStream;
  var nameController = new TextEditingController();

  void addActivity() {}

  void closePage() {
    Navigator.pop(context);
  }

  void openRunPage() {}

  @override
  void initState() {
    super.initState();
    presetBloc = BlocProvider.of<PresetBloc>(context);
    presetBlocStream = presetBloc.stream.listen((event) {
      setState(() {
        preset = event.presets.firstWhere((element) => element.id == id);
      });
    });
    Future.delayed(Duration.zero, () {
      Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
      setState(() {
        id = arguments['id'];
        preset =
            presetBloc.state.presets.firstWhere((element) => element.id == id);
      });
    });
  }

  @override
  void dispose() {
    // presetBloc.close();
    presetBlocStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BlocBuilder<PresetBloc, PresetState>(builder: (context, state) {
          return Text(preset?.name ?? '');
        }),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  addActivity();
                },
                child: Icon(Icons.add),
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          Text("test"),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          openRunPage();
        },
      ),
    );
  }
}
