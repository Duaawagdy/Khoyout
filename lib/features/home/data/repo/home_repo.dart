import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';
import 'package:khouyot/features/home/data/model/offers_model.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';

class HomeRepo{
  Dio dio;
  HomeRepo(this.dio);
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
  }

  Future<Either<ApiErrorModel,List<Offer>>> getOffers()async{
    try{
      var response = await dio.get(ApiConstants.offers);
      final List<Offer> categories =
      (response.data['data'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      return left(ApiErrorHandler.handle(e));

    }
  }Future<Either<ApiErrorModel,List<ProductModel>>> getProducts()async{
    try{
      var response = await dio.get(ApiConstants.products);
      final List<ProductModel> categories =
      (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print(e);
      return left(ApiErrorHandler.handle(e));

    }
  }
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
      print(e);
      return left(ApiErrorHandler.handle(e));

    }
  }
  Future<Either<ApiErrorModel,List<ProductModel>>> getBestSellerProducts()async{
    try{
      var response = await dio.get("${ApiConstants.products}/bestsellers?sort=best_seller");
      final List<ProductModel> categories =
      (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print("best error${e}");
      return left(ApiErrorHandler.handle(e));

    }
  }
  Future<Either<ApiErrorModel,List<ProductModel>>> getFeaturedProducts()async{
    try{
      var response = await dio.get("${ApiConstants.products}/featured");
      final List<ProductModel> categories =
      (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print("best error${e}");
      return left(ApiErrorHandler.handle(e));

    }
  }

  Future<Either<ApiErrorModel,List<ProductModel>>> getFavouriteProducts()async{
    try{
      var response = await dio.get("favorites/${ApiConstants.products}");
      final List<ProductModel> categories =
      (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return Right(categories);
    }catch(e){
      print("best error${e}");
      return left(ApiErrorHandler.handle(e));

    }
  }
}