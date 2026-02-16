import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

import '../../../../core/errors/error_handler.dart';

class CategoriesRepo {
  Dio dio;
  CategoriesRepo({required this.dio});
  Future<Either<ApiErrorModel,List<Category>>> getCategories()async{
    try{
      var response = await dio.get(ApiConstants.categories);
      final List<Category> categories =
      (response.data['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print('error cat${e}');
      return left(ApiErrorHandler.handle(e));

    }
  } Future<Either<ApiErrorModel,List<ProductModel>>> getCategoryProducts(int id)async{
    try{
      var response = await dio.get("${ApiConstants.categories}/$id");
      final List<ProductModel> product =
      (response.data['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(product);
    }catch(e){
      print('error catproduct${e}');
      return left(ApiErrorHandler.handle(e));

    }
  }
}