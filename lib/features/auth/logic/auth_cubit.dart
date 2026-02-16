
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cash_helper.dart';
import '../../../core/errors/api_error_model.dart';
import '../data/models/otp_model.dart';
import '../data/models/sign_in_model.dart';
import '../data/models/sign_in_response.dart';
import '../data/models/sign_up_model.dart';
import '../data/models/sign_up_response.dart';
import '../data/models/verfy_code_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  AuthRepo authRepo;
  static AuthCubit get(context) => BlocProvider.of(context);
  bool isLogin = true;
    void changeAuthMode(){
      isLogin=!isLogin;
    emit(AuthModeChangedState());
    }

    bool showPassword=true;
    void changePasswordVisibility(){
      showPassword=!showPassword;
      emit(AuthPasswordVisibilityChangedState());
    }
    bool isOtpScreen=false;
    void changeToOtpScreen(bool toOtp){
      isOtpScreen=toOtp;
      emit(AuthOtpScreenChangedState());
    }
  int index = 0;
  void focusNextField(BuildContext context) {
    if (index < 3) { // Update to 3 since the last index is 3 for 4 fields
      index++;
      FocusScope.of(context).nextFocus();
    }
  }

  void focusPreviousField(BuildContext context) {
    if (index > 0) {
      index--;
      FocusScope.of(context).previousFocus();
    }
  }

  void clearOtpFields(List<TextEditingController> otpControllers) {
    for (var controller in otpControllers) {
      controller.clear(); // Clear the text field
    }
    index = 0; // Reset index to the first field
  }
  Future<void> signUp(SignUpModel signUpModel) async {
    emit(SignUpLoading());
    final response = await authRepo.signUp( signUpModel);
    response.fold(
          (l) => emit(SignUpFailure( l )),
          (r) {

        CashHelper.setStringSecured(
          key: Keys.signUpResponse,
          value: r.toJson(),
        );

        emit(SignUpSuccess(signUpResponse: r));
      },
    );
  }  Future<void> resendSignUpcode(String email) async {

    final response = await authRepo.resendSignUpCode( email: email);

  }
  Future<void> signIn(SignInModel signInModel) async {
    emit(SignInLoading());
    final response = await authRepo.signIn(signIn: signInModel);
    response.fold(
          (l) => emit(SignInFailure(l)),
          (r) {
        // Save sign-in response securely
        CashHelper.setStringSecured(
          key: Keys.signInResponse,
          value: r.toJson(),
        );
        CashHelper.setStringSecured(
          key: Keys.token,
          value: r.token!,
        );
        emit(SignInSuccess(signInResponse: r));
      },
    );
  }
  Future<void> verifySignUp(OtpModel ot) async {
    emit(VerifySignUpLoading());
    final response = await authRepo.verifySignUpCode(email: ot.email!,code: ot.otp!);
    response.fold(
          (l) => emit(SignUpFailure( l )),
          (r) {
        // Save sign-in response securely
        CashHelper.setStringSecured(
          key: Keys.signUpResponse,
          value: r.toString(),
        );
        CashHelper.setStringSecured(
          key: Keys.token,
          value: r.token!,
        );
        emit(VerifySignUpSuccess(signUpResponse: r));
      },
    );
  }
}
