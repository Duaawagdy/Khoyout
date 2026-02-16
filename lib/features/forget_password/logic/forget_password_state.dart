part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String email;
  ForgetPasswordSuccess(this.email);
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final ApiErrorModel error;

  ForgetPasswordFailure( this.error);
}
final class ForgetPasswordLoading extends ForgetPasswordState {}
final class PasswordVisibilityChangedState extends ForgetPasswordState {}
final class ResetPasswordSuccess extends ForgetPasswordState {}
final class VerifyCodeSuccess extends ForgetPasswordState {
  final String resetKey;
  final String email;
  VerifyCodeSuccess(this.resetKey,this.email);
}
