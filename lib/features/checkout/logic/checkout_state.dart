part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}
final class CheckoutPaymentMethodSelected extends CheckoutState {}
final class CheckoutLoading extends CheckoutState {}
final class CheckoutSuccess extends CheckoutState {
  final OrderResponse orderResponse;
  CheckoutSuccess(this.orderResponse);
}
final class CheckoutError extends CheckoutState {}
final class DragPositionChanged extends CheckoutState {}
