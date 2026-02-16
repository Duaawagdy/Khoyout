import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/features/auth/data/models/sign_up_model.dart';
import 'package:khouyot/features/auth/data/models/sign_up_response.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/networking/api_constants.dart';
import '../models/sign_in_model.dart';
import '../models/sign_in_response.dart';
import '../models/verfy_code_response.dart';

class AuthRepo{
  Dio dio;
  AuthRepo(this.dio);
  Future<Either<ApiErrorModel,SignUpResponse>> signUp (SignUpModel signUpModel)
  async{
    try {
      Response response =
      await dio.post(ApiConstants.registeration, data: signUpModel.toMap());
      return Right(SignUpResponse.fromMap(response.data));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel, VerifyCodeResponse>> verifySignUpCode({
    required String email,required String code
  }) async {
    try {
      Response response =
      await dio.post(ApiConstants.verifyRegisteration, data: {"email":email,"otp":code});
      return Right(VerifyCodeResponse.fromJson(response.data));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }

  }
  Future<Either<ApiErrorModel, VerifyCodeResponse>> resendSignUpCode({
    required String email
  }) async {
    try {
      Response response =
      await dio.post(ApiConstants.resendSignupCode, data: {"email":email});
      return Right(response.data['success']);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }

  }
  Future<Either<ApiErrorModel, SignInResponse>> signIn(
      {required SignInModel signIn}) async {
    try {
      Response response =
      await dio.post(ApiConstants.login, data: signIn.toMap());
      return Right(SignInResponse.fromMap(response.data));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}