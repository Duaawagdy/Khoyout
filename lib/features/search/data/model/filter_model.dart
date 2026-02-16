import 'dart:ui';

class FilterModel {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final List<ColorFilter> colors;
  final List<SizeFilter> sizes;
  final PriceRange price;
  final StockInfo stock;

  FilterModel({
    required this.categories,
    this.selectedCategory,
    required this.colors,
    required this.sizes,
    required this.price,
    required this.stock,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      categories: (json['categories'] as List<dynamic>)
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
      selectedCategory: json['selected_category'] != null
          ? CategoryModel.fromJson(json['selected_category'])
          : null,
      colors: (json['colors'] as List<dynamic>)
          .map((color) => ColorFilter.fromJson(color))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((size) => SizeFilter.fromJson(size))
          .toList(),
      price: PriceRange.fromJson(json['price']),
      stock: StockInfo.fromJson(json['stock']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((c) => c.toJson()).toList(),
      'selected_category': selectedCategory?.toJson(),
      'colors': colors.map((c) => c.toJson()).toList(),
      'sizes': sizes.map((s) => s.toJson()).toList(),
      'price': price.toJson(),
      'stock': stock.toJson(),
    };
  }

  FilterModel copyWith({
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    List<ColorFilter>? colors,
    List<SizeFilter>? sizes,
    PriceRange? price,
    StockInfo? stock,
  }) {
    return FilterModel(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}

// ========================================
// Category Model
// ========================================

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? image;
  final String description;
  final String descriptionAr;
  final int? parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    required this.description,
    required this.descriptionAr,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String?,
      description: json['description'] as String,
      descriptionAr: json['description_ar'] as String,
      parentId: json['parent_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'description': description,
      'description_ar': descriptionAr,
      'parent_id': parentId,
    };
  }

  // Helper getters
  bool get hasImage => image != null && image!.isNotEmpty;
  bool get isParentCategory => parentId == null;
  bool get isSubCategory => parentId != null;

  CategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? description,
    String? descriptionAr,
    int? parentId,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      parentId: parentId ?? this.parentId,
    );
  }
}

// ========================================
// Color Filter Model
// ========================================

class ColorFilter {
  final List<int> ids;
  final String name;
  final String valueAr;
  final String valueCode;
  final String optionCode;
  final int variantsCount;
  final String hex;
  final String? swatchUrl;
  bool isSelected; // For UI selection state

  ColorFilter({
    required this.ids,
    required this.name,
    required this.valueAr,
    required this.valueCode,
    required this.optionCode,
    required this.variantsCount,
    required this.hex,
    this.swatchUrl,
    this.isSelected = false,
  });

  factory ColorFilter.fromJson(Map<String, dynamic> json) {
    return ColorFilter(
      ids: (json['ids'] as List<dynamic>).map((id) => id as int).toList(),
      name: json['name'] as String,
      valueAr: json['value_ar'] as String,
      valueCode: json['value_code'] as String,
      optionCode: json['option_code'] as String,
      variantsCount: json['variants_count'] as int,
      hex: json['hex'] as String,
      swatchUrl: json['swatch_url'] as String?,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ids': ids,
      'name': name,
      'value_ar': valueAr,
      'value_code': valueCode,
      'option_code': optionCode,
      'variants_count': variantsCount,
      'hex': hex,
      'swatch_url': swatchUrl,
    };
  }

  // Helper methods
  Color get color => _hexToColor(hex);

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  ColorFilter copyWith({
    List<int>? ids,
    String? name,
    String? valueAr,
    String? valueCode,
    String? optionCode,
    int? variantsCount,
    String? hex,
    String? swatchUrl,
    bool? isSelected,
  }) {
    return ColorFilter(
      ids: ids ?? this.ids,
      name: name ?? this.name,
      valueAr: valueAr ?? this.valueAr,
      valueCode: valueCode ?? this.valueCode,
      optionCode: optionCode ?? this.optionCode,
      variantsCount: variantsCount ?? this.variantsCount,
      hex: hex ?? this.hex,
      swatchUrl: swatchUrl ?? this.swatchUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// ========================================
// Size Filter Model
// ========================================

class SizeFilter {
  final List<int> ids;
  final String name;
  final String valueAr;
  final String valueCode;
  final String optionCode;
  final int variantsCount;
  bool isSelected; // For UI selection state

  SizeFilter({
    required this.ids,
    required this.name,
    required this.valueAr,
    required this.valueCode,
    required this.optionCode,
    required this.variantsCount,
    this.isSelected = false,
  });

  factory SizeFilter.fromJson(Map<String, dynamic> json) {
    return SizeFilter(
      ids: (json['ids'] as List<dynamic>).map((id) => id as int).toList(),
      name: json['name'] as String,
      valueAr: json['value_ar'] as String,
      valueCode: json['value_code'] as String,
      optionCode: json['option_code'] as String,
      variantsCount: json['variants_count'] as int,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ids': ids,
      'name': name,
      'value_ar': valueAr,
      'value_code': valueCode,
      'option_code': optionCode,
      'variants_count': variantsCount,
    };
  }

  SizeFilter copyWith({
    List<int>? ids,
    String? name,
    String? valueAr,
    String? valueCode,
    String? optionCode,
    int? variantsCount,
    bool? isSelected,
  }) {
    return SizeFilter(
      ids: ids ?? this.ids,
      name: name ?? this.name,
      valueAr: valueAr ?? this.valueAr,
      valueCode: valueCode ?? this.valueCode,
      optionCode: optionCode ?? this.optionCode,
      variantsCount: variantsCount ?? this.variantsCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// ========================================
// Price Range Model
// ========================================

class PriceRange {
  final double min;
  final double max;

  PriceRange({
    required this.min,
    required this.max,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
    };
  }

  // Helper methods
  String get formattedRange => '\$${min.toInt()} - \$${max.toInt()}';
  double get range => max - min;

  PriceRange copyWith({
    double? min,
    double? max,
  }) {
    return PriceRange(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}

// ========================================
// Stock Info Model
// ========================================

class StockInfo {
  final int inStockVariants;

  StockInfo({
    required this.inStockVariants,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      inStockVariants: json['in_stock_variants'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'in_stock_variants': inStockVariants,
    };
  }

  // Helper getters
  bool get hasStock => inStockVariants > 0;
  bool get isOutOfStock => inStockVariants == 0;

  StockInfo copyWith({
    int? inStockVariants,
  }) {
    return StockInfo(
      inStockVariants: inStockVariants ?? this.inStockVariants,
    );
  }
}