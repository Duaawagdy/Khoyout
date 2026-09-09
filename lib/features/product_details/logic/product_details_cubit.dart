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
  String selectedSizeName = '';

  static const _sizeRank = {
    'xs': 0, 's': 1, 'm': 2, 'l': 3, 'xl': 4,
    'xxl': 5, '2x': 5, '2xl': 5, '3x': 6, '3xl': 6,
  };

  String? _optionValue(VariantModel v, String option) {
    for (final o in v.options) {
      if (o.option?.toLowerCase().trim() == option) {
        return o.value?.trim();
      }
    }
    return null;
  }

  /// كل المقاسات الموجودة في المنتج، مرتّبة
  List<String> get allSizes {
    final variants = productDetailsModel.data?.variants ?? [];
    final set = <String>{};
    for (final v in variants) {
      final s = _optionValue(v, 'size');
      if (s != null && s.isNotEmpty) set.add(s);
    }
    final list = set.toList();
    list.sort((a, b) {
      final ra = _sizeRank[a.toLowerCase()] ?? 99;
      final rb = _sizeRank[b.toLowerCase()] ?? 99;
      return ra != rb ? ra.compareTo(rb) : a.compareTo(b);
    });
    return list;
  }

  bool get hasSizes => allSizes.isNotEmpty;

  /// المقاسات المتاحة للّون المختار (في المخزون)
  Set<String> get availableSizes {
    final variants = productDetailsModel.data?.variants ?? [];
    final result = <String>{};
    for (final v in variants) {
      if (v.stock <= 0) continue;
      if (selectedVarientName.isNotEmpty &&
          _optionValue(v, 'color')?.toLowerCase() !=
              selectedVarientName.toLowerCase()) {
        continue;
      }
      final s = _optionValue(v, 'size');
      if (s != null && s.isNotEmpty) result.add(s);
    }
    return result;
  }

  void selectSize(String size) {
    if (!availableSizes.contains(size)) return;
    selectedSizeName = size;
    _resolveVariant();
    emit(SelectVarientSize());
  }

  /// بيلاقي الـ variant المطابق للّون + المقاس
  void _resolveVariant() {
    final variants = productDetailsModel.data?.variants ?? [];

    for (final v in variants) {
      final colorOk = selectedVarientName.isEmpty ||
          _optionValue(v, 'color')?.toLowerCase() ==
              selectedVarientName.toLowerCase();
      final sizeOk = !hasSizes ||
          selectedSizeName.isEmpty ||
          _optionValue(v, 'size')?.toLowerCase() ==
              selectedSizeName.toLowerCase();

      if (colorOk && sizeOk) {
        selectedVarientId = v.id ?? -1;
        if (v.image != null && v.image!.isNotEmpty) featuredImages = v.image!;

        final inCart = productDetailsModel.variantCart
            ?.where((e) => e.variantId == selectedVarientId)
            .firstOrNull;
        productQuantity = inCart?.cartQuantity ?? 1;
        return;
      }
    }

    selectedVarientId = -1;
  }
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
    selectedVarientName = name;

    // لو المقاس الحالي مش متاح مع اللون الجديد، امسحه
    if (selectedSizeName.isNotEmpty &&
        !availableSizes.contains(selectedSizeName)) {
      selectedSizeName = '';
    }

    _resolveVariant();
    emit(SelectVarientColor());
  }  ReviewsResponse ? reviewsResponse;
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
