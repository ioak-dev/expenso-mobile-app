import 'package:endurance/database/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  ActivityListItem({Key? key, required this.activity}) : super(key: key);

  Activity activity;

  handleClick(context) {
    print(activity);
    Navigator.pushNamed(context, '/activity/view', arguments: {'id': activity.id});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activity.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("${10}s", textAlign: TextAlign.start)
                    ])),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("10 acts, 5 rests")],
                ))
          ],
        ),
      ),
      onTap: () {
        handleClick(context);
      },
    );
  }
}
