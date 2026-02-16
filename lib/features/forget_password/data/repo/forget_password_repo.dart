import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_model.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/networking/api_constants.dart';
import '../model/reset_password_request.dart';

class ForgetPasswordRepo{
Dio dio;
ForgetPasswordRepo(this.dio);
Future<Either<ApiErrorModel, String>> forgetPassword({
  required String email,
}) async {
  try {
    Response response =
    await dio.post(ApiConstants.forgotPassword, data: {"email": email});
    return Right(response.data['message']);
  } catch (e) {
    return Left(ApiErrorHandler.handle(e));
  }
}
Future<Either<ApiErrorModel, String>> resendCode({
  required String email,
}) async {
  try {
    Response response =
    await dio.post(ApiConstants.resendCode, data: {"email": email});
    return Right(response.data['message']);
  } catch (e) {
    return Left(ApiErrorHandler.handle(e));
  }
}
Future<Either<ApiErrorModel, String>> verifyCode({
  required String email,
  required String otp,
}) async {
  try {
    Response response =
    await dio.post(ApiConstants.verifyCode, data: {"email": email,"otp":otp});
    return Right(response.data['reset_key']);
  } catch (e) {
    return Left(ApiErrorHandler.handle(e));
  }
}
Future<Either<ApiErrorModel, String>> resetNewPassword({
  required ResetPasswordRequest re
}) async {
  try {
    Response response =
    await dio.post(ApiConstants.verifyCode, data: re.toJson());
    return Right(response.data['message']);
  } catch (e) {
    return Left(ApiErrorHandler.handle(e));
  }
}
}