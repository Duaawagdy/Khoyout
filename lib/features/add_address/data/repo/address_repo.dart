import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';

import '../model/add_address_model.dart';

class AddressRepo{
  Dio dio;
  AddressRepo(this.dio);
  Future<Either<ApiErrorModel, Response>> addAddress(AddAddressModel addressData)async{
    try{
      Response response=await dio.post('/addresses',data: addressData.toJson());
      return Right(response);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
  Future<Either<ApiErrorModel, Response>> editAddress(AddAddressModel addressData,int id)async{
    try{
      Response response=await dio.put('/addresses/$id',data: addressData.toJson());
      return Right(response);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
  Future<Either<ApiErrorModel,List<AddressesModel>>> getAddresses()async{
    try{
      Response response=await dio.get('/addresses');
      List<AddressesModel> addresses=(response.data['data'] as List).map((e) => AddressesModel.fromJson(e)).toList();
      return Right(addresses);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
  Future<Either<ApiErrorModel, Response>> setDefaultAddress(int id)async{
    try{
      Response response=await dio.post('addresses/$id/set-default');
      return Right(response);

    }catch(e){
      return Left(ApiErrorModel(message: e.toString()));
    }
  }
}