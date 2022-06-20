import 'package:endurance/database/database_provider.dart';
import 'package:endurance/preset/preset_list/preset_list_item.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:flutter/material.dart';

class PresetList extends StatefulWidget {
  const PresetList({Key? key}) : super(key: key);

  @override
  State<PresetList> createState() => _PresetListState();
}

class _PresetListState extends State<PresetList> {
  List<Preset> presets = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshPresets();
  }

  @override
  void dispose() {
    super.dispose();
    DatabaseProvider.instance.close();
  }

  Future refreshPresets() async {
    setState(() => isLoading = true);
    presets = await DatabaseProvider.instance.readAllPreset();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: presets.length,
      itemBuilder: (context, index) {
        return PresetListItem(preset: presets[index]);
      },
    ));
  }
}
