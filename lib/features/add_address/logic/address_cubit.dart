import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/add_address/data/model/add_address_model.dart';
import 'package:khouyot/features/add_address/data/model/address_model.dart';
import 'package:khouyot/features/add_address/data/repo/address_repo.dart';
import 'package:meta/meta.dart';


part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addressRepo) : super(AddressInitial());
  AddressRepo addressRepo;
  static AddressCubit get(context) => BlocProvider.of(context);
  List<AddressesModel> addresses=[];
  Future<void> addAddress (AddAddressModel ad)async{
    emit(AddAddressLoading());
var response=await addressRepo.addAddress(ad);
response.fold((l){
  emit(AddAddressError());
}, (r){
  //getAddress();
  emit(AddAddressSuccess());
});
  }
Future<void> getAddress()async{
    emit(AddressLoading());
var response=await addressRepo.getAddresses();
response.fold((l){
  emit(AddressError());
}, (r){
  addresses=r;
  emit(AddressGetSuccess());
});
  }
  Future<void> setDefaultAddress(int id)async{
    emit(AddressLoading());
  var response=await addressRepo.setDefaultAddress(id);
  response.fold((l){
    emit(AddressError());
  }, (r){
    getAddress();
  });
  }

  Future<void> editAddress(AddAddressModel addAddressModel,int id) async{
    emit(AddAddressLoading());
    var response=await addressRepo.editAddress(addAddressModel,id);
    response.fold((l){
      emit(AddAddressError());
    }, (r){

      emit(AddAddressSuccess());
    });
  }
}
