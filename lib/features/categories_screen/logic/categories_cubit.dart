import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/categories_screen/data/repo/categories_repo.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());
  CategoriesRepo categoriesRepo;
  static CategoriesCubit get(context) => BlocProvider.of(context);
  List<Category> categories=[];
  Future<void> getCategories()async{
    emit(GetCategoriesLoading());
    var response= await categoriesRepo.getCategories();
    response.fold((l){
      emit(GetCategoriesError());
    }, (r){
      categories=r;
      emit(GetCategoriesSuccess());
    });
  }
  List<ProductModel> products=[];
  Future<void> getCategoryProducts(int id)async{
    emit(GetCategoriesLoading());
    var response= await categoriesRepo.getCategoryProducts(id);
    response.fold((l){
      emit(GetCategoriesError());
    }, (r){
      products=r;
      emit(GetCategoriesSuccess());
    });
  }
}
