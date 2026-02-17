import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/product_details/data/model/add_to_cart_response.dart';
import 'package:khouyot/features/product_details/data/model/product_details_model.dart';
import 'package:khouyot/features/product_details/data/repo/product_details_repo.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cash_helper.dart';
import '../data/model/reviews_response.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productDetailsRepo) : super(ProductDetailsInitial());
  ProductDetailsRepo productDetailsRepo;
  static ProductDetailsCubit get(context)=> BlocProvider.of(context);
   ProductDetailsResponse productDetailsModel= ProductDetailsResponse(data: null, success: false,  isFavorite: false);
  int selectedVarientId=-1;
  int productQuantity=1;
  String selectedVarientName='';
  String featuredImages='';
  void updateQuantity(String st){
    if(st=='add'){
      productQuantity++;
    }
    else{
      productQuantity--;
    }
    emit(UpdatedQuantity());
  }
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
  void selectColor(String name, List<VariantModel> variants) {
    for (final variant in variants) {
      final hasColor = variant.options.any(
            (option) =>
        option.option?.toLowerCase() == 'color' &&
            option.value?.toLowerCase() == name.toLowerCase(),
      );

      if (hasColor) {
        selectedVarientId = variant.id!;
        featuredImages = variant.image!;
        selectedVarientName = name;
        print(productDetailsModel.variantCart);

productQuantity=productDetailsModel.variantCart?.where((variant) => variant.variantId == selectedVarientId).first.cartQuantity??1;
        emit(SelectVarientColor());
        return; // stop once found
      }
    }

    // Optional: handle not found

  }
  ReviewsResponse ? reviewsResponse;
  Future<void> getReviews(int id)async{
    emit(GetReviewsLoading());
    var response =await productDetailsRepo.getReviews(id);
    response.fold((l){
      emit(GetReviewsError());
    }, (r){
      reviewsResponse=r;
      emit(GetReviewsSuccess());
    });
  }
  Future<void> addToCart()async{
    emit(AddToCartLoading());
    var response=await productDetailsRepo.addToCart(selectedVarientId,productQuantity);
    response.fold((l){
      emit(AddToCartError());
    }, (r){
      emit(AddToCartSuccess(cartResponse: r));
    });
  }
  Future<void> getProductDetails(int id)async {
    productDetailsModel= ProductDetailsResponse(data: null, success: false, isFavorite: false);
    emit(GetProductDetailsLoading());
    var response =await productDetailsRepo.getProductDetails(id: id);
    response.fold((l){
      print('${l.message}');
      emit(GetProductDetailsError());
    }, (r){
      //selectedVarientId=r.data.matrix[r.colors.first.name]['_']["variant_id"];
      featuredImages=r.data!.firstImage!;
      selectedVarientName='';
      productQuantity=r.data!.cartQuantity;
      productDetailsModel=r;
      emit(GetProductDetailsSuccess());
    });
  }
  bool ?isTapFav;
  void tapFav(bool isfav){
    if(isTapFav==null){
      isTapFav=!isfav;
    }
    else{
      isTapFav=!isTapFav!;
    }

    emit(ToggleButtonFav());
  }
}
