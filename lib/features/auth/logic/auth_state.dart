part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class AuthModeChangedState extends AuthState {}
class AuthPasswordVisibilityChangedState extends AuthState {}
class AuthOtpScreenChangedState extends AuthState {}

//sign UP states
final class SignUpFailure extends AuthState {
  final ApiErrorModel error;

  SignUpFailure( this.error);
}
final class SignUpSuccess extends AuthState {
  final SignUpResponse signUpResponse;
  SignUpSuccess({required this.signUpResponse});
}
final class SignUpLoading extends AuthState {}

//verify sign up code
final class VerifySignUpSuccess extends AuthState {
  final VerifyCodeResponse signUpResponse;
  VerifySignUpSuccess({required this.signUpResponse});
}
final class VerifySignUpFailure extends AuthState {}
final class VerifySignUpLoading extends AuthState {}


//sign in state
final class SignInLoading extends AuthState {}
final class SignInFailure extends AuthState {
  final ApiErrorModel error;

  SignInFailure( this.error);
}
final class SignInSuccess extends AuthState {
  final SignInResponse signInResponse;
  SignInSuccess({required this.signInResponse});
}