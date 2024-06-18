abstract class SurvellianceState {}

class SurvellianceInitialState extends SurvellianceState {}

class SurvellianceLoadingState extends SurvellianceState {}

class TiltUpLoadingState extends SurvellianceState {}

class TiltDownLoadingState extends SurvellianceState {}

class PanLeftLoadingState extends SurvellianceState {}

class PanRightLoadingState extends SurvellianceState {}

class StreamLoadingState extends SurvellianceState {}

class StatusLoadingState extends SurvellianceState {}

class SurvellianceErrorState extends SurvellianceState {
  final String errorMessage;

  SurvellianceErrorState({required this.errorMessage});
}

class TiltUpSuccessfulState extends SurvellianceState {
  final String message;

  TiltUpSuccessfulState({required this.message});
}

class TiltDownSuccessfulState extends SurvellianceState {
  final String message;

  TiltDownSuccessfulState({required this.message});
}

class CenterSuccessfulState extends SurvellianceState {
  final String message;

  CenterSuccessfulState({required this.message});
}

class PanLeftSuccessfulState extends SurvellianceState {
  final String message;

  PanLeftSuccessfulState({required this.message});
}

class PanRightSuccessfulState extends SurvellianceState {
  final String message;

  PanRightSuccessfulState({required this.message});
}

class StatusSuccessfulState extends SurvellianceState {
  final String message;

  StatusSuccessfulState({required this.message});
}

class StreamSuccessfulState extends SurvellianceState {
  final String message;

  StreamSuccessfulState({required this.message});
}
