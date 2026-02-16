import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/favourites/data/repo/fav_repo.dart';
import 'package:khouyot/features/home/data/model/product_model.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit(this.favRepo) : super(FavInitial());
  FavRepo favRepo;
  static FavCubit get(context) => BlocProvider.of(context);
  List<ProductModel> favs = [];
  Future<void> getFav() async {
    emit(GetFavsLoading());

    var response = await favRepo.getFavouriteProducts();
    response.fold((l) {
      emit(GetFavsError());
    }, (r) {
      favs = r;
      emit(GetFavsSuccess());
    });
  }  Future<void> toggleFav(int id) async {
    emit(ToggleFavsLoading());

    var response = await favRepo.addToFav(id);
    response.fold((l) {
      emit(ToggleFavsError());
    }, (r) {
getFav();
      emit(ToggleFavsSuccess());
    });
  }
}
