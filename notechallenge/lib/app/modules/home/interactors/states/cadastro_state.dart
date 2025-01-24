abstract interface class CadastroState {}

class StartCadastroState implements CadastroState {
  const StartCadastroState();
}

class SuccessCadastroState implements CadastroState {
  const SuccessCadastroState();
}

class SuccessGlobalCadastroState implements CadastroState {
  const SuccessGlobalCadastroState();
}

class ErrorExceptionCadastroState implements CadastroState {
  final String error;

  const ErrorExceptionCadastroState({required this.error});
}

class EmptyCadastroState implements CadastroState {
  const EmptyCadastroState();
}

class LoadingCadastroState implements CadastroState {
  const LoadingCadastroState();
}
