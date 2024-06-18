import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illumin_eye_mobile/data/remote/streetlight_service.dart';
import 'package:illumin_eye_mobile/views/features/vm/streetlight-vm/streetlight_state.dart';

final StreetlightService _service = StreetlightService();

class StreetlightCubit extends Cubit<StreetlightState> {
  StreetlightCubit() : super(StreetlightInitialState());

  Future<void> turnOn() async {
    emit(TurnOnLoadingState());
    try {
      final response = await _service.turnOnEndpoint();
      emit(TurnOnSuccessfulState(message: response));
    } catch (e) {
      emit(StreetlightErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> turnOff() async {
    emit(TurnOnLoadingState());
    try {
      final response = await _service.turnOffEndpoint();
      emit(TurnOffSuccessfulState(message: response));
    } catch (e) {
      emit(StreetlightErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> automatic() async {
    emit(TurnOnLoadingState());
    try {
      final response = await _service.automaticEndpoint();
      emit(AutomaticSuccessfulState(message: response));
    } catch (e) {
      emit(StreetlightErrorState(errorMessage: e.toString()));
    }
  }
}
