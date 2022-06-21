import 'package:equatable/equatable.dart';

const String tableActivity = 'activity';

class ActivityFields {
  static final List<String> values = [
    id,
    name,
    presetId,
    createdAt,
    modifiedAt
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String presetId = 'presetId';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';
}

class Activity extends Equatable {
  final int? id;
  final String name;
  final int presetId;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Activity({this.id, required this.name, required this.presetId});

  Map<String, dynamic> toMap() {
    return {
      ActivityFields.id: id,
      ActivityFields.name: name,
      ActivityFields.presetId: presetId,
      ActivityFields.createdAt: createdAt?.toIso8601String(),
      ActivityFields.modifiedAt: modifiedAt?.toIso8601String()
    };
  }

  static Activity fromMap(Map<String, dynamic> map) {
    Activity activity = Activity(
        id: map[ActivityFields.id] as int,
        name: map[ActivityFields.name] as String,
        presetId: map[ActivityFields.presetId] as int);

    activity.createdAt =
        DateTime.parse(map[ActivityFields.createdAt] as String);
    activity.modifiedAt =
        DateTime.parse(map[ActivityFields.modifiedAt] as String);

    return activity;
  }

  Activity copy(
      {int? id,
      String? name,
      int? presetId,
      DateTime? createdAt,
      DateTime? modifiedAt}) {
    Activity activity = Activity(
        id: id ?? this.id,
        name: name ?? this.name,
        presetId: presetId ?? this.presetId);
    activity.createdAt = createdAt ?? this.createdAt;
    activity.modifiedAt = modifiedAt ?? this.modifiedAt;
    return activity;
  }

  @override
  String toString() {
    return 'Activity{id: $id, name: $name, presetId: $presetId, createdAt: $createdAt, modifiedAt: $modifiedAt}';
  }

  @override
  List<Object> get props => [id!, name, presetId];
}
