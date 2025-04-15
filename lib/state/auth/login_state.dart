abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String generalError;
  final Map<String, String> fieldErrors;

  LoginError(this.generalError, {this.fieldErrors = const {}});
}