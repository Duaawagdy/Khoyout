import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/my_orders/data/model/orders_model.dart';

class OrdersRepo{
  Dio dio;
  OrdersRepo(this.dio);
  Future<Either<ApiErrorModel,List<MyOrderModel>>> getOrders()async{
try{
  var response= await dio.get('user/orders');
  List<MyOrderModel> orders= (response.data['data'] as List).map((e) => MyOrderModel.fromJson(e)).toList();
  return right(orders);
}catch(e){
  return left(ApiErrorHandler.handle(e));
}
  } Future<Either<ApiErrorModel,AddressesModel>> getAddress(int id)async{
try{
  var response= await dio.get('addresses/$id');
  return right(AddressesModel.fromJson(response.data['data']));
}catch(e){
  print(e);
  return left(ApiErrorHandler.handle(e));
}
  }

 Future<Either <ApiErrorModel,String>> setRating(int id, int rating, String comment,String title) async{
    try{
      var response =await dio.post('reviews',data: {
        "order_item_id": id,
        "rating": rating,
        "title": title,
        "message": comment
      });
      return right('added');
    }catch(e){
      return left(ApiErrorHandler.handle(e));
    }
 }
}