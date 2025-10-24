abstract class LoginState {
  LoginState();

  LoginState copyWith();
}

class LoginInitial extends LoginState {
  LoginInitial() : super();

  @override
  LoginState copyWith() => LoginInitial();
}

class LoginLoading extends LoginState {
  LoginLoading() : super();

  @override
  LoginState copyWith() => LoginLoading();
}

class LoginData extends LoginState {
  LoginData();

  @override
  LoginState copyWith() => LoginData();
}

class LoginError extends LoginState {
  LoginError() : super();

  @override
  LoginState copyWith() => LoginError();
}
