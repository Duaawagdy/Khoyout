part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}
final class OrdersLoading extends OrdersState {}
final class OrdersFailure extends OrdersState {}
final class OrdersSuccess extends OrdersState {}
final class SelectStatus extends OrdersState {}
final class getAddressLoading extends OrdersState {}
final class getAddressError extends OrdersState {}
final class getAddressSuccess extends OrdersState {}
final class SetRatingState extends OrdersState {}
final class SetReviewLoadingState extends OrdersState {}
final class SetReviewFailureState extends OrdersState {}
final class SetReviewSuccessState extends OrdersState {}
