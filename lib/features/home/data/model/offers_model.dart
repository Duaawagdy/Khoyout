class Offer {
  final int id;
  final String title;
  final String description;
  final String type; // percentage | fixed
  final String value;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OfferProduct> products;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      value: json['value'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      products: (json['products'] as List)
          .map((e) => OfferProduct.fromJson(e))
          .toList(),
    );
  }
}
class OfferProduct {
  final int id;
  final String name;
  final String price;
  final List<String> images;
  final num finalPrice;
  final num minPrice;
  final num maxPrice;
  final String priceRange;
  final int totalStock;
  final bool isAvailable;
  final bool inStock;
  final OfferPivot pivot;

  OfferProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.finalPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.priceRange,
    required this.totalStock,
    required this.isAvailable,
    required this.inStock,
    required this.pivot,
  });

  factory OfferProduct.fromJson(Map<String, dynamic> json) {
    return OfferProduct(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      images: List<String>.from(json['images']),
      finalPrice: json['final_price'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      priceRange: json['price_range'],
      totalStock: json['total_stock'],
      isAvailable: json['is_available'],
      inStock: json['in_stock'],
      pivot: OfferPivot.fromJson(json['pivot']),
    );
  }
}
class OfferPivot {
  final int offerId;
  final int productId;

  OfferPivot({
    required this.offerId,
    required this.productId,
  });

  factory OfferPivot.fromJson(Map<String, dynamic> json) {
    return OfferPivot(
      offerId: json['offer_id'],
      productId: json['product_id'],
    );
  }
}
