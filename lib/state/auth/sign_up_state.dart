abstract class SignUpState {}

// حالة البداية
class SignUpInitial extends SignUpState {}

// حالة التحميل
class SignUpLoading extends SignUpState {}

// حالة النجاح
class SignUpSuccess extends SignUpState {}

// حالة الخطأ العامة
class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

// حالة خطأ التحقق من الحقول
class SignUpValidationError extends SignUpState {
  final Map<String, String> fieldErrors;
  SignUpValidationError(this.fieldErrors);
}

// حالة التحقق الفردي للحقول
class SignUpFieldValidation extends SignUpState {
  final Map<String, String> fieldErrors;
  SignUpFieldValidation(this.fieldErrors);
}

// حالة تغيير رؤية كلمة المرور
class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isVisible;
  SignUpPasswordVisibilityChanged(this.isVisible);
}
