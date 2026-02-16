import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/forget_password/data/model/reset_password_request.dart';
import 'package:khouyot/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/api_error_model.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  ForgetPasswordRepo forgetPasswordRepo;
  static  ForgetPasswordCubit get(context) => BlocProvider.of(context);
  bool showPassword=false;
  void changePasswordVisibility(){
    showPassword=!showPassword;
    emit(PasswordVisibilityChangedState());
  }
  bool isOtpScreen=false;
  // void changeToOtpScreen(bool toOtp){
  //   isOtpScreen=toOtp;
  //   emit(ResetPasswordState());
  // }
  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final response = await forgetPasswordRepo.forgetPassword(email: email);
    response.fold(
            (l) => emit(ForgetPasswordFailure( l )),
            (r)  {
          emit(ForgetPasswordSuccess(email));
        }
    );
  }
  Future<void> verifyRestPasswordCode(String email,String otp) async {
    emit(ForgetPasswordLoading());
    final response = await forgetPasswordRepo.verifyCode(email: email,otp: otp);
    response.fold(
            (l) => emit(ForgetPasswordFailure( l )),
            (r)  {
          emit(VerifyCodeSuccess(r,email));
        }
    );
  }
  Future<void> restNewPassword(ResetPasswordRequest re) async {
    emit(ForgetPasswordLoading());
    final response = await forgetPasswordRepo.resetNewPassword(re: re);
    response.fold(
            (l) => emit(ForgetPasswordFailure( l )),
            (r)  {
          emit(ResetPasswordSuccess());
        }
    );
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
}
