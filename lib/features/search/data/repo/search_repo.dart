import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/features/search/data/model/filter_model.dart';

import '../../../../core/errors/api_error_model.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../home/data/model/product_model.dart';

class SearchRepo{
  Dio dio;
  SearchRepo(this.dio);
  Future<Either<ApiErrorModel,List<ProductModel>>> getSearchProducts(String quary)async{
    try{
      var response = await dio.get(ApiConstants.products,queryParameters: {
        "q":quary
      });
      final List<ProductModel> categories =
      (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print('error search${e}');
      return left(ApiErrorHandler.handle(e));

    }
  }  Future<Either<ApiErrorModel,FilterModel>> getAvailableFilter()async{
    try{
      var response = await dio.get('${ApiConstants.products}/available-filter');


      return Right(FilterModel.fromJson(response.data['data']));
    }catch(e){
      print('error search${e}');
      return left(ApiErrorHandler.handle(e));

    }
  }

  Future<Either<ApiErrorModel,List<ProductModel>>>searchWithFilters(Map<String, Object> filters) {
    try {
      return dio.get(ApiConstants.products, queryParameters: filters).then((response) {
        final List<ProductModel> products =
        (response.data['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return Right(products);
      });
    } catch (e) {
      print('error search with filters: $e');
      return Future.value(Left(ApiErrorHandler.handle(e)));
    }
  }
}