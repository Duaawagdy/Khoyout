class Category {
  final int id;
  final String name;
  final String? nameAr;
  final String slug;
  final String? image;
  final String? description;
  final String? descriptionAr;
  final bool focus;
  final List<SubCategory> subCategories;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.nameAr,
    this.image,
    this.description,
    this.descriptionAr,
    this.focus = false,
    this.subCategories = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String?,
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String?,
      description: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      focus: json['focus'] ,
      subCategories: (json['sub_categories'] as List<dynamic>? ?? [])
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_ar': nameAr,
    'slug': slug,
    'image': image,
    'description': description,
    'description_ar': descriptionAr,
    'focus': focus,
    'sub_categories': subCategories.map((e) => e.toJson()).toList(),
  };

  bool get hasSubCategories => subCategories.isNotEmpty;

  String localizedName(String locale) =>
      locale == 'ar' && nameAr != null && nameAr!.isNotEmpty ? nameAr! : name;
}

class SubCategory {
  final int id;
  final int categoryId;
  final String name;
  final String? nameAr;
  final String slug;
  final String? image;
  final String? description;
  final String? descriptionAr;

  const SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    this.nameAr,
    this.image,
    this.description,
    this.descriptionAr,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int,
      categoryId: json['category_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String?,
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String?,
      description: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'name': name,
    'name_ar': nameAr,
    'slug': slug,
    'image': image,
    'description': description,
    'description_ar': descriptionAr,
  };

  String localizedName(String locale) =>
      locale == 'ar' && nameAr != null && nameAr!.isNotEmpty ? nameAr! : name;
}