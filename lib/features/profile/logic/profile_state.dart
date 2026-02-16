part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetProfileLoading extends ProfileState {}
final class GetProfileSuccess extends ProfileState {}
final class GetProfileError extends ProfileState {}
final class UpdateProfileLoading extends ProfileState {}
final class UpdateProfileSuccess extends ProfileState {}
final class UpdateProfileError extends ProfileState {}
final class EditModeToggled extends ProfileState {}
final class GetGuestModeState extends ProfileState {}
