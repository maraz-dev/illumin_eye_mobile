import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illumin_eye_mobile/data/remote/survelliance_service.dart';
import 'package:illumin_eye_mobile/views/features/vm/survelliance-vm/survelliance_state.dart';

final SurvellianceService _service = SurvellianceService();

class SurvellianceCubit extends Cubit<SurvellianceState> {
  SurvellianceCubit() : super(SurvellianceInitialState());

  Future<void> tiltUp() async {
    emit(TiltUpLoadingState());
    try {
      final response = await _service.tiltUpEndpoint();
      emit(TiltUpSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> tiltDown() async {
    emit(TiltDownLoadingState());
    try {
      final response = await _service.tiltDownEndpoint();
      emit(TiltDownSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> center() async {
    emit(CenterLoadingState());
    try {
      final response = await _service.centerEndpoint();
      emit(CenterSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> panLeft() async {
    emit(PanLeftLoadingState());
    try {
      final response = await _service.panLeftEndpoint();
      emit(PanLeftSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> panRight() async {
    emit(PanRightLoadingState());
    try {
      final response = await _service.panRightEndpoint();
      emit(PanRightSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> streamMethod() async {
    emit(StreamLoadingState());
    try {
      final response = await _service.centerEndpoint();
      emit(StreamSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> status() async {
    emit(StatusLoadingState());
    try {
      final response = await _service.centerEndpoint();
      emit(StatusSuccessfulState(message: response));
    } catch (e) {
      emit(SurvellianceErrorState(errorMessage: e.toString()));
    }
  }
}
