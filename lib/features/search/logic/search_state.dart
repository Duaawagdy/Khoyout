part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class GetSearchProductsLoading extends SearchState {}
final class GetSearchProductsError extends SearchState {}
final class GetSearchProductsSuccess extends SearchState {}
final class GetAvailableFilterLoading extends SearchState {}
final class GetAvailableFilterError extends SearchState {}
final class GetAvailableFilterSuccess extends SearchState {}
final class FilterUpdated extends SearchState {}
