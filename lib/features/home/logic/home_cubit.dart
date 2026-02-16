import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/features/home/data/model/category_model.dart';
import 'package:khouyot/features/home/data/model/offers_model.dart';
import 'package:meta/meta.dart';

import '../data/model/product_model.dart';
import '../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;
  static  HomeCubit get(context) =>BlocProvider.of(context);

List<ProductModel> products=[];
List<ProductModel> bestSellerProducts=[];
List<ProductModel> featuredProducts=[];
int itemCount=0;
   void addItem(int index) {
    products[index].cartQuantity++;
    emit(HomeUpdateProductState());
  }

  void removeItem(int index) {
    if (products[index].cartQuantity > 0) {
      products[index].cartQuantity--;
      emit(HomeUpdateProductState());
    }
  }
  void addFeatureItem(int index) {
     print('add feature item');
    featuredProducts[index].cartQuantity++;
    print('quantity:${featuredProducts[index].cartQuantity}');
    emit(HomeUpdateProductState());
  }

  void removeFeatureItem(int index) {
    if (featuredProducts[index].cartQuantity > 0) {
      featuredProducts[index].cartQuantity--;
      emit(HomeUpdateProductState());
    }
  }
  void addBestItem(int index) {
    bestSellerProducts[index].cartQuantity++;
    emit(HomeUpdateProductState());
  }

  void removeBestItem(int index) {
    if (bestSellerProducts[index].cartQuantity > 0) {
      bestSellerProducts[index].cartQuantity--;
      emit(HomeUpdateProductState());
    }
  }
  List<Category> categories=[];

  Future<void> getCategories()async{
    emit(GetCategoriesLoading());
    var response= await homeRepo.getCategories();
    response.fold((l){
      emit(GetCategoriesError());
    }, (r){
      categories=r;
      emit(GetCategoriesSuccess());
    });
  }
  List<Offer> offers=[];
bool guestMode=false;
Future<void> getGuestMode()async{
  String mode= await CashHelper.getStringSecured(key: Keys.guestMode);
  if(mode=='guest'){
    guestMode=true;}
  else{
    guestMode=false;
  }
  emit(GetGuestModeState());
}
  Future<void> getOffers()async{
    emit(GetOffersLoading());
    var response= await homeRepo.getOffers();
    response.fold((l){
      emit(GetOffersError());
    }, (r){
      offers=r;
      emit(GetOffersSuccess());
    });
  }
  void toggleFav(int index, bool value, String list){
    if(list=='products'){
products[index].isFavorite=value;
    }
    else if(list=='features'){
featuredProducts[index].isFavorite=value;
    }else{
      bestSellerProducts[index].isFavorite=value;
    }
    emit(ToggleFavState());
  }
  Future<void> getProducts()async{
    emit(GetProductsLoading());
    var response= await homeRepo.getProducts();
    response.fold((l){
      print('erroe${l}');
      emit(GetProductsError());
    }, (r){
      products=r;
      emit(GetProductsSuccess());
    });

}

  Future<void> getBestSellerProducts()async{
    emit(GetBestProductsLoading());
    var response= await homeRepo.getBestSellerProducts();
    response.fold((l){
      print('erroe${l}');
      emit(GetBestProductsError());
    }, (r){
      bestSellerProducts=r;
      emit(GetBestProductsSuccess());
    });
  }
  Future<void> getFeaturedProducts()async{
    emit(GetFeaturedProductsLoading());
    var response= await homeRepo.getFeaturedProducts();
    response.fold((l){
      print('erroe${l}');
      emit(GetFeaturedProductsError());
    }, (r){
      featuredProducts=r;
      emit(GetFeaturedProductsSuccess());
    });
  }
}
