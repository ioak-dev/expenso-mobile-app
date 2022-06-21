import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/activity/activity_list/activity_list_item.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  List<Activity> activitys = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshActivitys();
  }

  void refreshActivitys() async {
    final activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBloc.add(FetchActivitys());
    // setState(() => isLoading = true);
    // activitys = await DatabaseProvider.instance.readAllActivity();
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
        itemCount: state.activitys.length,
        itemBuilder: (context, index) {
          return ActivityListItem(activity: state.activitys[index]);
        },
      ));
    });
  }
}
