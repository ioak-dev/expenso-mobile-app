import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preset_event.dart';
part 'preset_state.dart';

class PresetBloc extends Bloc<PresetEvent, PresetState> {
  PresetBloc() : super(const PresetState()) {
    on<FetchPresetEvent>(_onPresetFetched);
  }

  Future<void> _onPresetFetched (FetchPresetEvent event, Emitter<PresetState> emit) async {
    await DatabaseProvider.instance.readAllPreset();
  }
}
