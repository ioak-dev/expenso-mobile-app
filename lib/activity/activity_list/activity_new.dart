import 'package:flutter/material.dart';

class ActivityNew extends StatefulWidget {
  const ActivityNew({Key? key}) : super(key: key);

  @override
  State<ActivityNew> createState() => _ActivityNewState();
}

class _ActivityNewState extends State<ActivityNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      child: Column(children: [
        TextField(),
        SizedBox(
          height: 40,
        ),
        ButtonBar(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Cancel")),
            ElevatedButton(onPressed: () {}, child: Text("Save"))
          ],
        )
      ]),
    );
  }
}
