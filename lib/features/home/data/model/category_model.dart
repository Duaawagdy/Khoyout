class Category {
  final int id;
  final String? name;
  final String? slug;
   int? parentId;
  final String? image;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.slug,
     this.parentId,
    required this.image,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name']??'',
      slug: json['slug']??'',
      //parentId: json['parent_id'],
      image: json['image']??'',
      children: json['children'] != null
          ? List<Category>.from(
        json['children'].map((e) => Category.fromJson(e)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parent_id': parentId,
      'image': image,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }
}
