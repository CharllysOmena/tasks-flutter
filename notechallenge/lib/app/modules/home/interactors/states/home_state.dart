import 'package:notechallenge/app/modules/home/data/entities/nota_entities.dart';

abstract interface class HomeState {}

class StartHomeState implements HomeState {
  const StartHomeState();
}

class SuccessHomeState implements HomeState {
  final List<Nota>? notas;
  const SuccessHomeState({this.notas});
}

class ErrorExceptionHomeState implements HomeState {
  final String error;

  const ErrorExceptionHomeState({required this.error});
}

class EmptyHomeState implements HomeState {
  const EmptyHomeState();
}

class LoadingHomeState implements HomeState {
  const LoadingHomeState();
}
