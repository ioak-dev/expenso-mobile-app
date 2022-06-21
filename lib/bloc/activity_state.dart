part of 'activity_bloc.dart';

class ActivityState extends Equatable {
  const ActivityState({this.activitys = const <Activity>[], this.isLoading = false});

  final List<Activity> activitys;
  final bool isLoading;

  @override
  List<Object> get props => [activitys, isLoading];

  ActivityState copyWith({
    List<Activity>? activitys,
    bool? isLoading,
  }) {
    return ActivityState(
        activitys: activitys ?? this.activitys,
        isLoading: isLoading ?? this.isLoading);
  }
}

class ActivityInitial extends ActivityState {
  @override
  List<Object> get props => [];
}
