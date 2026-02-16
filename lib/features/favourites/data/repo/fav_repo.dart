import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_model.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../home/data/model/product_model.dart';

class FavRepo {
  Dio dio;
  FavRepo(this.dio);
  Future<Either<ApiErrorModel, List<ProductModel>>>
      getFavouriteProducts() async {
    try {
      var response = await dio.get("favorites/${ApiConstants.products}");
      final List<ProductModel> categories = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    } catch (e) {
      print("fav error$e");
      return left(ApiErrorHandler.handle(e));
    }
  }Future<Either<ApiErrorModel, String>>
      addToFav(int id) async {
    try {
      var response = await dio.post("favorites/toggle/$id");


      return Right(response.data['message']);
    } catch (e) {
      print("fav error$e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
