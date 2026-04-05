import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/cart_screen/data/model/cart_reponse_model.dart';
import 'package:khouyot/features/cart_screen/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo cartRepo;
  CartCubit(this.cartRepo) : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  List<CartItem> cartResponse=[];
  int totalusd=0;
  int subtotal=0;
  int seppingFee=0;
  Future<void> deleteCartItem(int id) async {
    emit(DeleteItemLoadingState());
    var response=await cartRepo.deleteProduct(id);
    response.fold((l) {
      emit(DeleteItemErrorState());
    }, (r) {
      cartResponse.removeWhere((item) => item.id == id);
      emit(DeleteItemSuccessState());
    });
  }
  Future<void> getCartItems() async {
    emit(CartLoadingState());
  var response=await cartRepo.getCart();
    response.fold((l) {
      emit(CartErrorState());
    }, (r) {
      cartResponse=r.items;
      totalusd=r.totalEgp;
      subtotal=r.subtotalEgp;
      seppingFee=r.shipping;
      emit(CartLoadedState());
    });
  }
  Future<void> addToCart(int selectedVarientId,int productQuantity,int index)async{
    emit(AddToCartLoading());
    var response=await cartRepo.addToCart(selectedVarientId,productQuantity);
    response.fold((l){
      print('error is $l');
      emit(AddToCartError());
    }, (r){
      print('add product');
      getCartItems();
     cartResponse[index].quantity=productQuantity;
     cartResponse[index].lineTotalUsd=r.lineTotalEgp;
      emit(AddToCartSuccess());
    });
  }
}
