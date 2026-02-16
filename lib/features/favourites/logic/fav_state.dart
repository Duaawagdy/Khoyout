part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}
final class GetFavsError extends FavState {}
final class GetFavsLoading extends FavState {}
final class GetFavsSuccess extends FavState {}
final class ToggleFavsLoading extends FavState {}
final class ToggleFavsSuccess extends FavState {}
final class ToggleFavsError extends FavState {}
