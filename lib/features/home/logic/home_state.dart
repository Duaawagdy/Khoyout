part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeUpdateProductState extends HomeState {}
final class GetCategoriesSuccess extends HomeState {}
final class GetCategoriesError extends HomeState {}
final class GetCategoriesLoading extends HomeState {}
final class GetOffersSuccess extends HomeState {}
final class GetOffersError extends HomeState {}
final class GetOffersLoading extends HomeState {}
final class GetProductsSuccess extends HomeState {}
final class GetProductsError extends HomeState {}
final class GetProductsLoading extends HomeState {}
final class GetBestProductsSuccess extends HomeState {}
final class GetBestProductsError extends HomeState {}
final class GetBestProductsLoading extends HomeState {}
final class GetFeaturedProductsSuccess extends HomeState {}
final class GetFeaturedProductsError extends HomeState {}
final class GetFeaturedProductsLoading extends HomeState {}
final class ToggleFavState extends HomeState {}
final class GetGuestModeState extends HomeState {}