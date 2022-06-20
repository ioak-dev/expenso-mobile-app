part of 'preset_bloc.dart';

class PresetState extends Equatable {
  final List<Preset> presets;

  const PresetState({this.presets = const <Preset>[]});

  PresetState copyWith({List<Preset>? presets}) {
    return PresetState(presets: presets ?? this.presets);
  }

  @override
  String toString() {
    return 'PresetState{presets: ${presets.length}';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
