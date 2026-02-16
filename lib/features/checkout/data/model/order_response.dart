

import '../../../add_address/data/model/address_model.dart';

class OrderResponse {
  final OrderModel order;
  final String trackingLink;
  final PaymentModel payment;
  final String paymentMethod;

  OrderResponse({
    required this.order,
    required this.trackingLink,
    required this.payment,
    required this.paymentMethod,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      order: OrderModel.fromJson(json['order']),
      trackingLink: json['tracking_link'] as String,
      payment: PaymentModel.fromJson(json['payment']),
      paymentMethod: json['payment_method'] as String,
    );
  }
}

class OrderModel {
  final int id;
  final int? userId;
  final String? guestUuid;
  final double total;
  final String status;
  final int? addressId;
  final double shippingCost;
  final String? trackingNumber;
  final String createdAt;
  final String createdAtIso;
  final String? updatedAt;
  final List<OrderItem> items; // Changed from orderItems
  final AddressesModel address;

  OrderModel({
    required this.id,
    this.userId,
    this.guestUuid,
    required this.total,
    required this.status,
    this.addressId,
    required this.shippingCost,
    this.trackingNumber,
    required this.createdAt,
    required this.createdAtIso,
    this.updatedAt,
    required this.items,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      userId: json['user_id'] as int?,
      guestUuid: json['guest_uuid'] as String?,
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      addressId: json['address_id'] as int?,
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      trackingNumber: json['tracking_number'] as String?,
      createdAt: json['created_at'] as String,
      createdAtIso: json['created_at_iso'] as String,
      updatedAt: json['updated_at'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      address: AddressesModel.fromJson(json['address']),
    );
  }

  // Helper getters
  bool get isPending => status == 'pending';
  bool get isConfirmed => status == 'confirmed';
  bool get isShipped => status == 'shipped';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

class OrderItem {
  final int id;
  final int? orderId;
  final int? productId;
  final int quantity;
  final double price;
  final String? createdAt;
  final String? updatedAt;
  final ProductInfo? product; // Added product info
  final dynamic variant;

  OrderItem({
    required this.id,
    this.orderId,
    this.productId,
    required this.quantity,
    required this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.variant,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as int,
      orderId: json['order_id'] as int?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product: json['product'] != null
          ? ProductInfo.fromJson(json['product'])
          : null,
      variant: json['variant'],
    );
  }

  double get subtotal => price * quantity;
}

// New class for product info in order item
class ProductInfo {
  final int id;
  final String name;
  final String slug;
  final String image;

  ProductInfo({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }
}

class PaymentModel {
  final int id;
  final int orderId;
  final String paymentMethod;
  final String status;
  final double amount;
  final String transactionId;
  final String createdAt;
  final String updatedAt;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.paymentMethod,
    required this.status,
    required this.amount,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      paymentMethod: json['payment_method'] as String,
      status: json['status'] as String,
      amount: (json['amount'] as num).toDouble(),
      transactionId: json['transaction_id'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  bool get isPending => status == 'pending';
  bool get isPaid => status == 'paid';
  bool get isFailed => status == 'failed';

  bool get isCashOnDelivery =>
      paymentMethod == 'cash_on_delivery' || paymentMethod == 'cod';
}
