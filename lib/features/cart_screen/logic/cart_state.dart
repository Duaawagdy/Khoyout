part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoadingState extends CartState {}
final class CartErrorState extends CartState {}
final class CartLoadedState extends CartState {}
final class DeleteItemLoadingState extends CartState {}
final class DeleteItemErrorState extends CartState {}
final class DeleteItemSuccessState extends CartState {}
final class AddToCartLoading extends CartState {}
final class AddToCartError extends CartState {}
final class AddToCartSuccess extends CartState {}
