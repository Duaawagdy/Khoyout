part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}
class GetProductDetailsLoading extends ProductDetailsState {}
class GetProductDetailsError extends ProductDetailsState {}
class GetProductDetailsSuccess extends ProductDetailsState {}
class SelectVarientColor extends ProductDetailsState {}
class UpdatedQuantity extends ProductDetailsState {}
class AddToCartLoading extends ProductDetailsState {}
class AddToCartError extends ProductDetailsState {}
class AddToCartSuccess extends ProductDetailsState {
  final AddCartResponse cartResponse;
  AddToCartSuccess({required this.cartResponse});
}
class GetReviewsLoading extends ProductDetailsState {}
class GetReviewsError extends ProductDetailsState {}
class GetReviewsSuccess extends ProductDetailsState {}
class ToggleButtonFav extends ProductDetailsState {}