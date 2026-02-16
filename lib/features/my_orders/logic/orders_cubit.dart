import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/my_orders/data/model/orders_model.dart';
import 'package:khouyot/features/my_orders/data/repo/Orders_repo.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepo) : super(OrdersInitial());
  OrdersRepo ordersRepo;
  static OrdersCubit get(context) => BlocProvider.of(context);
  List<String> status = [
    'All',
    'pending',
    'processing',
    'shipped',
    'delivered',
    'cancelled'
  ];
  int color = 0xff0000000;
  int selectedIndex = 0;
  void selectStatus(int index) {
    selectedIndex = index;
    if (index == 0) {
      filterdProduct = orders;
    } else {
      filterdProduct=orders.where((element) => element.status==status[index].toLowerCase()).toList();
    }
    emit(SelectStatus());
  }
  void setStatusColor() {}
  List<MyOrderModel> orders = [];
  List<MyOrderModel> filterdProduct = [];
  Future<void> getOrders() async {
    emit(OrdersLoading());
    var response = await ordersRepo.getOrders();
    response.fold((l) => emit(OrdersFailure()), (r) {
      orders = r;
      filterdProduct = orders;
      emit(OrdersSuccess());

    });
  }
  AddressesModel?addressModel;

  int rating=0;
  Future<void> getSingleAddress(int id)async{
    emit(getAddressLoading());
    var response =await ordersRepo.getAddress(id);
    response.fold((l){
      print(l);
      emit(getAddressError());
    }, (r){
      addressModel=r;
      emit(getAddressSuccess());
    });
  }
  Future<void> setReview(int id,String comment,String title) async {
    emit(SetReviewLoadingState());
    final response = await ordersRepo.setRating(id, rating, comment,title);
    response.fold((error) {
      emit(SetReviewFailureState());
      print(' error $error');
    }, (categories) {
      //print(categories[0].status);
      emit(SetReviewSuccessState());
    });
  }
  void setRating(int i) {
    rating = i;
    emit(SetRatingState());
  }
}
