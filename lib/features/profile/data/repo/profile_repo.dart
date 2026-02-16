import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';

import '../model/change_password_model.dart';
import '../model/profile_model.dart';

class ProfileRepo{
  Dio dio;
  ProfileRepo(this.dio);
  Future<Either<ApiErrorModel,ProfileModel>> getProfile()async{
    try{
      Response response=await dio.get('/profile');

        ProfileModel profile=ProfileModel.fromJson(response.data['user']);
        return Right(profile);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
  Future<Either<ApiErrorModel,String>> updateProfile(String name)async{
    try{
      Response response=await dio.put('/profile',data: {
        "name":name
      });

        return Right(response.data['message']);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }Future<Either<ApiErrorModel,String>> changePassword(ChangePasswordModel ch)async{
    try{
      Response response=await dio.put('/profile/password',data:ch.toJson() );

        return Right(response.data['message']);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
}