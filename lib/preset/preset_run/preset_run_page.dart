import 'dart:async';

import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';

class PresetRunPage extends StatefulWidget {
  const PresetRunPage(
      {Key? key, required this.presetId, this.startFromActivityId})
      : super(key: key);

  final int presetId;
  final int? startFromActivityId;

  @override
  State<PresetRunPage> createState() => _PresetRunPageState();
}

class _PresetRunPageState extends State<PresetRunPage> {
  late ActivityBloc activityBloc;
  StreamSubscription? activityBlocStream;
  List<Activity> activities = [];
  List<Activity> remainingActivities = [];
  Activity? activity;
  Timer? timer;
  Duration duration = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBlocStream = activityBloc.stream.listen((event) {
      readActivitiesFromState(event.activities);
    });
    readActivitiesFromState(activityBloc.state.activities);
    startTimer();
  }

  void readActivitiesFromState(List<Activity> activities) {
    List<Activity> activitiesForPreset = activities
        .where((element) => element.presetId == widget.presetId)
        .toList();
    if (widget.startFromActivityId != null) {
      final int index = activitiesForPreset
          .indexWhere((element) => element.id == widget.startFromActivityId);
      activitiesForPreset = activitiesForPreset.sublist(index);
    }
    setState(() {
      activities = activitiesForPreset;
      remainingActivities = activitiesForPreset;
    });
  }

  void startTimer() {
    print(remainingActivities);
    if (remainingActivities.length > 0) {
      setState(() {
        activity = remainingActivities[0];
        duration = Duration(
            hours: remainingActivities[0].hour,
            minutes: remainingActivities[0].minute,
            seconds: remainingActivities[0].second);
      });
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setCountDown();
      });
    }
  }

  void setCountDown() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer!.cancel();
        remainingActivities = remainingActivities.sublist(1);
        startTimer();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    // presetBloc.close();
    timer?.cancel();
    activityBlocStream?.cancel();
    super.dispose();
  }

  void closePage() {
    Navigator.pop(context);
  }

  void pause() {}

  void stop() {}

  Widget renderBody() {
    return AnimatedContainer(
      color:
          activity == null ? Colors.transparent : Color(activity?.color ?? 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: const Duration(milliseconds: 1000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 60,
                color: getFontColorForBackground(Color(activity?.color ?? 0))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(activity?.color ?? 000),
        title: Text(activity?.name ?? ''),
        centerTitle: true,
      ),
      body: renderBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
          heroTag: 'pause-run',
          child: const Icon(Icons.pause),
          onPressed: () {
            pause();
          },
        )
      ]),
    );
  }
}
