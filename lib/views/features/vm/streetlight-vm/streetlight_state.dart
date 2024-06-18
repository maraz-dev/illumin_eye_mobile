abstract class StreetlightState {}

class StreetlightInitialState extends StreetlightState {}

class StreetlightLoadingState extends StreetlightState {}

class TurnOnLoadingState extends StreetlightState {}

class TurnOffLoadingState extends StreetlightState {}

class AutomaticLoadingState extends StreetlightState {}

class TurnOnSuccessfulState extends StreetlightState {
  final String message;

  TurnOnSuccessfulState({required this.message});
}

class TurnOffSuccessfulState extends StreetlightState {
  final String message;

  TurnOffSuccessfulState({required this.message});
}

class AutomaticSuccessfulState extends StreetlightState {
  final String message;

  AutomaticSuccessfulState({required this.message});
}

class StreetlightErrorState extends StreetlightState {
  final String errorMessage;

  StreetlightErrorState({required this.errorMessage});
}
