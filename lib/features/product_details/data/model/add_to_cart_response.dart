class AddCartResponse {
  final int id;
  final int quantity;
  final CartProduct product;
  final CartVariant variant;
  //final num unitPriceUsd;
  final num unitPriceEgp;
  //final num lineTotalUsd;
  final num lineTotalEgp;

  AddCartResponse({
    required this.id,
    required this.quantity,
    required this.product,
    required this.variant,

    required this.unitPriceEgp,

    required this.lineTotalEgp,
  });

  factory AddCartResponse.fromJson(Map<String, dynamic> json) {
    return AddCartResponse(
      id: json['id'],
      quantity: json['quantity'],
      product: CartProduct.fromJson(json['product']),
      variant: CartVariant.fromJson(json['variant']),
      //unitPriceUsd: json['unit_price_usd'],
      unitPriceEgp: json['unit_price'],
     // lineTotalUsd: json['line_total_usd'],
      lineTotalEgp: json['line_total_egp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toJson(),
      'variant': variant.toJson(),
      'unit_price_egp': unitPriceEgp,
      'line_total_egp': lineTotalEgp,
    };
  }
}
class CartProduct {
  final int id;
  final String name;
  final String slug;
  final String image;

  CartProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
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
class CartVariant {
  final int id;
  final String sku;
  final String image;
  final int stock;
  final String stockStatus;
  final List<dynamic> options;
  final String? colorHex;

  CartVariant({
    required this.id,
    required this.sku,
    required this.image,
    required this.stock,
    required this.stockStatus,
    required this.options,
    this.colorHex,
  });

  factory CartVariant.fromJson(Map<String, dynamic> json) {
    return CartVariant(
      id: json['id'],
      sku: json['sku'],
      image: json['image'],
      stock: json['stock'],
      stockStatus: json['stock_status'],
      options: json['options'] ?? [],
      colorHex: json['color_hex']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'image': image,
      'stock': stock,
      'stock_status': stockStatus,
      'options': options,
      'color_hex': colorHex,
    };
  }
}
