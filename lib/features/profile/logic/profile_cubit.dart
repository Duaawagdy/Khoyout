import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/features/profile/data/model/change_password_model.dart';
import 'package:khouyot/features/profile/data/model/profile_model.dart';
import 'package:khouyot/features/profile/data/repo/profile_repo.dart';
import 'package:khouyot/khouyot_app.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cash_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  ProfileRepo profileRepo;
  static ProfileCubit get(context) => BlocProvider.of(context);
   ProfileModel ?profile;
Future<void> getProfile()async{
  print('get profile called');
  emit(GetProfileLoading());
  var response= await profileRepo.getProfile();
  response.fold((l){
    emit(GetProfileError());
  }, (r){
    profile=r;

    emit(GetProfileSuccess());
  });
}
bool editMode=false;
void editToggle(){
  editMode=!editMode;
  emit(EditModeToggled());
}
Future<void> updateProfile(String name)async{
  print('get profile called');
  emit(UpdateProfileLoading());
  var response= await profileRepo.updateProfile(name);
  response.fold((l){
    emit(UpdateProfileError());
  }, (r){
    NavigationService.navigatorKey.currentContext?.pop();
    getProfile();

    emit(UpdateProfileSuccess());
  });
}
Future<void> ChangePassword(ChangePasswordModel ch)async{
  emit(UpdateProfileLoading());
  var response= await profileRepo.changePassword(ch);
  response.fold((l){
    emit(UpdateProfileError());
  }, (r){
    NavigationService.navigatorKey.currentContext?.pop();
    getProfile();

    emit(UpdateProfileSuccess());
  });
}
  bool guestMode=false;
  Future<void> getGuestMode()async{
    String mode= await CashHelper.getStringSecured(key: Keys.guestMode);
    if(mode=='guest'){
      guestMode=true;}
    else{
      guestMode=false;
    }
    emit(GetGuestModeState());
  }
}
