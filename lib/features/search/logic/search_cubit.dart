import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/search/data/model/filter_model.dart';
import 'package:khouyot/features/search/data/repo/search_repo.dart';
import 'package:meta/meta.dart';

import '../../home/data/model/product_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  final SearchRepo searchRepo;
  static SearchCubit get(context) => BlocProvider.of(context);

  List<ProductModel> searchProducts = [];
  FilterModel? filterModel;

  // Filter states
  List<int> selectedCategoryIds = [];
  List<String> selectedColorCodes = [];
  List<String> selectedSizeCodes = [];
  double minPrice = 0;
  double maxPrice = 1000;
  bool filterInStock = false;
  bool filterOnSale = false;
  int filteredProductsCount = 0;

  Future<void> getAvailableFilter() async {
    emit(GetAvailableFilterLoading());

    final result = await searchRepo.getAvailableFilter();

    result.fold(
          (failure) {
        emit(GetAvailableFilterError());
      },
          (data) {
        filterModel = data;
        minPrice = data.price.min;
        maxPrice = data.price.max;
        //filteredProductsCount = data.stock.inStockVariants;
        emit(GetAvailableFilterSuccess());
      },
    );
  }
  void toggleColor(ColorFilter color) {
    color.isSelected = !color.isSelected;
    if (color.isSelected) {
      selectedColorCodes.add(color.valueCode);
    } else {
      selectedColorCodes.remove(color.valueCode);
    }
    emit(FilterUpdated());
  }

  void toggleCategory(int categoryId) {
    if (selectedCategoryIds.contains(categoryId)) {
      selectedCategoryIds.remove(categoryId);
    } else {
      selectedCategoryIds.add(categoryId);
    }
    emit(FilterUpdated());
  }
  void toggleSize(SizeFilter size) {
    size.isSelected = !size.isSelected;
    if (size.isSelected) {
      selectedSizeCodes.add(size.valueCode);
    } else {
      selectedSizeCodes.remove(size.valueCode);
    }
    emit(FilterUpdated());
  }
  void toggleInStock() {
    filterInStock = !filterInStock;
    emit(FilterUpdated());
  }

  void toggleOnSale() {
    filterOnSale = !filterOnSale;
    emit(FilterUpdated());
  }

  void updatePriceRange(double min, double max) {
    minPrice = min;
    maxPrice = max;
    emit(FilterUpdated());
  }
  void clearFilters() {
    selectedCategoryIds.clear();
    selectedColorCodes.clear();
    selectedSizeCodes.clear();
    filterInStock = false;
    filterOnSale = false;

    if (filterModel != null) {
      minPrice = filterModel!.price.min;
      maxPrice = filterModel!.price.max;

      // Reset UI states
      for (var color in filterModel!.colors) {
        color.isSelected = false;
      }
      for (var size in filterModel!.sizes) {
        size.isSelected = false;
      }
    }

    emit(FilterUpdated());
  }
  Future<void> getSearchProducts(String q)async{
    emit(GetSearchProductsLoading());


    final result = await searchRepo.getSearchProducts(q);

    result.fold(
          (failure) {
        emit(GetSearchProductsError());
      },
          (products) {
        searchProducts = products;
        filteredProductsCount = products.length;
        emit(GetSearchProductsSuccess());
      },
    );
  }
  Future<void> applyFilters() async {
    emit(GetSearchProductsLoading());

    final filters = {
      'category_ids': selectedCategoryIds,
      'colors': selectedColorCodes,
      'sizes': selectedSizeCodes,
      'min_price': minPrice,
      'max_price': maxPrice,
      'in_stock': filterInStock,
      'on_sale': filterOnSale,
    };

    final result = await searchRepo.searchWithFilters(filters);

    result.fold(
          (failure) {
        emit(GetSearchProductsError());
      },
          (products) {
        searchProducts = products;
        filteredProductsCount = products.length;
        emit(GetSearchProductsSuccess());
      },
    );
  }
}