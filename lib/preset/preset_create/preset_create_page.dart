import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:flutter/material.dart';

class CreatePresetPage extends StatefulWidget {
  const CreatePresetPage({Key? key}) : super(key: key);

  @override
  State<CreatePresetPage> createState() => _CreatePresetPageState();
}

class _CreatePresetPageState extends State<CreatePresetPage> {
  int _currentIndex = 0;

  void _incrementCounter(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void closePage() {
    Navigator.pop(context);
  }

  void savePreset() async {
    await DatabaseProvider.instance.create(Preset(name: 'test'));
    print(await DatabaseProvider.instance.readAllPreset());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('New preset'),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    savePreset();
                  },
                  child: Icon(Icons.check),
                ))
          ],
          leading: GestureDetector(
            onTap: () {
              closePage();
            },
            child: Icon(Icons.close),
          )),
      body: const Center(
        child: Text('form'),
      ),
    );
  }
}
