import 'package:endurance/preset/preset_list/preset_list_item.dart';
import 'package:endurance/shared/preset.dart';
import 'package:flutter/material.dart';

class PresetList extends StatelessWidget {
  PresetList({Key? key, required this.activities}) : super(key: key);

  List<Preset> activities;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return PresetListItem(preset: activities[index]);
      },
    ));
  }
}
