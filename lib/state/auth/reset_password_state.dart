abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  final String? passwordError;
  final String? confirmPasswordError;

  ResetPasswordError({this.passwordError, this.confirmPasswordError});
}

class EmailError extends ResetPasswordState {
  final String? errorMsg;

  EmailError({this.errorMsg});
}

class EmailSuccess extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}
