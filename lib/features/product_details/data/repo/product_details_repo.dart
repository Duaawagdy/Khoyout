import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/features/product_details/data/model/add_to_cart_response.dart';
import 'package:khouyot/features/product_details/data/model/product_details_model.dart';

import '../../../../core/networking/api_constants.dart';
import '../model/reviews_response.dart';

class ProductDetailsRepo {
  Dio dio;
  ProductDetailsRepo({required this.dio});
  Future<Either<ApiErrorModel, ProductDetailsResponse>> getProductDetails(
      {required int id}) async {
    try {
      final response = await dio.get('${ApiConstants.products}/$id');

      final productDetails = ProductDetailsResponse.fromJson(response.data);
      print(productDetails.data?.name);
      return Right(productDetails);
    } catch (e) {
      print(e.toString());
      return Left(ApiErrorModel(message: e.toString()));
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
  Future<Either<ApiErrorModel, ReviewsResponse>> getReviews(int id) async {
    try {
      var response = await dio.get('products/$id/reviews');
      return right(ReviewsResponse.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
