import 'package:endurance/activity/activity_list/activity_list.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/activity/activity_list/activity_new.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
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
    Navigator.pushNamed(context, '/activity/create');
    // return showModalBottomSheet(
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (context) {
    //       return Wrap(children: const [ActivityNew()]);
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity list"),
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  openAddPage();
                },
                child: Icon(Icons.add),
              ))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          ActivityList(),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     openAddPage();
      //   },
      //   backgroundColor: Colors.grey,
      // ),
    );
  }
}
