import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/checkout/data/model/order_response.dart';
import 'package:khouyot/features/checkout/data/repo/checkout_repo.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());
  CheckoutRepo checkoutRepo;

  static CheckoutCubit get(context) => BlocProvider.of(context);

  String selectedPayment = '';
  double dragPosition = 0;

  void selectPaymentMethod(String value) {
    selectedPayment = value;
    emit(CheckoutPaymentMethodSelected());
  }

  Future<void> checkout(AddressesModel ad) async {
    emit(CheckoutLoading());
    print('Checkout loading state emitted');

    var result = await checkoutRepo.checkout(selectedPayment, ad);

    result.fold(
          (failure) {
        print('Checkout error: $failure');
        emit(CheckoutError());
      },
          (orderResponse) {
        print('Checkout success: ${orderResponse.toString()}');
        emit(CheckoutSuccess(orderResponse));
      },
    );
  }

  void onOrderConfirmed(AddressesModel ad) {
    // Reset drag position
    dragPosition = 0;
    emit(DragPositionChanged());

    // Proceed with checkout
    checkout(ad);
  }

  void horizentalDragUpdate(double delta, double maxDrag) {
    dragPosition += delta;
    dragPosition = dragPosition.clamp(0, maxDrag);
    emit(DragPositionChanged());
  }

  // Add this method to reset drag position
  void resetDragPosition() {
    dragPosition = 0;
    emit(DragPositionChanged());
  }
}