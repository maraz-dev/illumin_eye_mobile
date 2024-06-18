import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illumin_eye_mobile/views/features/vm/survelliance-vm/survelliance_state.dart';

class SurvellianceCubit extends Cubit<SurvellianceState> {
  SurvellianceCubit() : super(SurvellianceInitialState());

  Future<String> tiltUp() async {
    return '';
  }
}
