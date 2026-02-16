class MyOrderModel {
  final int id;
  final int userId;
  final String? guestUuid;
  final double total;
  final String status;
  final int addressId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? paymentId;
  final int? promoCodeId;
  final double promoDiscount;
  final List<OrderItemModel> orderItems;
  final dynamic payment;
  final List<TrackingHistoryModel> trackingHistory;

  MyOrderModel({
    required this.id,
    required this.userId,
    this.guestUuid,
    required this.total,
    required this.status,
    required this.addressId,
    required this.createdAt,
    required this.updatedAt,
    this.paymentId,
    this.promoCodeId,
    required this.promoDiscount,
    required this.orderItems,
    this.payment,
    required this.trackingHistory,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      id: json['id'],
      userId: json['user_id'],
      guestUuid: json['guest_uuid'],
      total: _toDouble(json['total']),
      status: json['status'],
      addressId: json['address_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      paymentId: json['payment_id'],
      promoCodeId: json['promo_code_id'],
      promoDiscount: _toDouble(json['promo_discount']),
      orderItems: (json['order_items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      payment: json['payment'],
      trackingHistory: (json['tracking_history'] as List)
          .map((e) => TrackingHistoryModel.fromJson(e))
          .toList(),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    return value is num ? value.toDouble() : double.parse(value.toString());
  }
}
class OrderItemModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool hasReview;
  final String productImage;
  final MyProductModel product;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.hasReview,
    required this.productImage,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: MyOrderModel._toDouble(json['price']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      hasReview: json['has_review'] ?? false,
      productImage: json['product_image'],
      product: MyProductModel.fromJson(json['product']),
    );
  }
}
class MyProductModel {
  final int id;
  final String name;
  final List<String> images;
  final double finalPrice;
  final double minPrice;
  final double maxPrice;
  final String priceRange;
  final int totalStock;
  final bool isAvailable;
  final bool inStock;
  final List<String> imagesUrls;

  MyProductModel({
    required this.id,
    required this.name,
    required this.images,
    required this.finalPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.priceRange,
    required this.totalStock,
    required this.isAvailable,
    required this.inStock,
    required this.imagesUrls,
  });

  factory MyProductModel.fromJson(Map<String, dynamic> json) {
    return MyProductModel(
      id: json['id'],
      name: json['name'],
      images: List<String>.from(json['images']),
      finalPrice: MyOrderModel._toDouble(json['final_price']),
      minPrice: MyOrderModel._toDouble(json['min_price']),
      maxPrice: MyOrderModel._toDouble(json['max_price']),
      priceRange: json['price_range'],
      totalStock: json['total_stock'],
      isAvailable: json['is_available'],
      inStock: json['in_stock'],
      imagesUrls: List<String>.from(json['images_urls']),
    );
  }
}
class TrackingHistoryModel {
  final int id;
  final int orderId;
  final String status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  TrackingHistoryModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrackingHistoryModel.fromJson(Map<String, dynamic> json) {
    return TrackingHistoryModel(
      id: json['id'],
      orderId: json['order_id'],
      status: json['status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
