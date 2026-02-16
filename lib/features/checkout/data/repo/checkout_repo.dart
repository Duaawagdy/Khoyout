import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/features/checkout/data/model/order_response.dart';

import '../../../add_address/data/model/address_model.dart';

class CheckoutRepo{
  Dio dio;
  CheckoutRepo(this.dio);
  Future<Either<ApiErrorModel,OrderResponse>> checkout(String paymentMethod,AddressesModel ad)async{
    try {
      final response = await dio.post('/checkout',data: {

          "payment_method": paymentMethod,
          "address_id": ad.id,
          "phone_number": ad.phoneNumber

      });
      //List<AddressModel> addresses = (response.data as List).map((e) => AddressModel.fromJson(e)).toList();
      return Right(OrderResponse.fromJson(response.data['data']));
    }  catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}