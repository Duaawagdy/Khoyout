import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../product_details/data/model/add_to_cart_response.dart';
import '../model/cart_reponse_model.dart';

class CartRepo{
  Dio dio;
  CartRepo({required this.dio});
  Future<Either<ApiErrorModel,CartResponse>> getCart()async{
    try{
      // Simulate API call
      var response = await dio.get('cart');
      // On success
      return Right(CartResponse.fromJson(response.data));
    }catch(e){
      // On failure
      return Left(ApiErrorHandler.handle(e));
    }
  }  Future<Either<ApiErrorModel,String>> deleteProduct(int id)async{
    try{
      // Simulate API call
      var response = await dio.delete('cart/remove/$id');
      // On success
      return Right(response.data['message']);
    }catch(e){
      // On failure
      return Left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel, AddCartResponse>> addToCart(int id, int qu) async {
    try {
      var response = await dio.post('cart/add/$id', data: {"quantity": "$qu"});
      return right(AddCartResponse.fromJson(response.data['data']));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}