class CartResponse {
  final bool success;
  final int itemsCount;
  final List<CartItem> items;
  final int subtotalUsd;
  final int subtotalEgp;
  final int discount;
  final int shipping;
  final int totalUsd;
  final int totalEgp;

  CartResponse({
    required this.success,
    required this.itemsCount,
    required this.items,
    required this.subtotalUsd,
    required this.subtotalEgp,
    required this.discount,
    required this.shipping,
    required this.totalUsd,
    required this.totalEgp,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'] ?? false,
      itemsCount: json['items_count'] ?? 0,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItem.fromJson(e))
          .toList(),
      subtotalUsd: json['subtotal_usd'] ?? 0,
      subtotalEgp: json['subtotal_egp'] ?? 0,
      discount: json['discount'] ?? 0,
      shipping: json['shipping'] ?? 0,
      totalUsd: json['total_usd'] ?? 0,
      totalEgp: json['total_egp'] ?? 0,
    );
  }
}
class CartItem {
  final int id;
   int quantity;
  final Product product;
  final Variant variant;
  final int unitPriceUsd;
  final int unitPriceEgp;
   num lineTotalUsd;
  final int lineTotalEgp;

  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
    required this.variant,
    required this.unitPriceUsd,
    required this.unitPriceEgp,
    required this.lineTotalUsd,
    required this.lineTotalEgp,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'] ?? 0,
      product: Product.fromJson(json['product']),
      variant: Variant.fromJson(json['variant']),
      unitPriceUsd: json['unit_price_usd'] ?? 0,
      unitPriceEgp: json['unit_price_egp'] ?? 0,
      lineTotalUsd: json['line_total_usd'] ?? 0,
      lineTotalEgp: json['line_total_egp'] ?? 0,
    );
  }
}
class Product {
  final int id;
  final String name;
  final String slug;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
class Variant {
  final int id;
  final String sku;
  final String image;
  final int stock;
  final String stockStatus;
  final List<VariantOption> options;
  final String? colorHex;

  Variant({
    required this.id,
    required this.sku,
    required this.image,
    required this.stock,
    required this.stockStatus,
    required this.options,
    this.colorHex,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      sku: json['sku'] ?? '',
      image: json['image'] ?? '',
      stock: json['stock'] ?? 0,
      stockStatus: json['stock_status'] ?? '',
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => VariantOption.fromJson(e))
          .toList(),
      colorHex: json['color_hex'],
    );
  }
}
class VariantOption {
  final String option;
  final String value;
  final OptionMeta? meta;

  VariantOption({
    required this.option,
    required this.value,
    this.meta,
  });

  factory VariantOption.fromJson(Map<String, dynamic> json) {
    return VariantOption(
      option: json['option'] ?? '',
      value: json['value'] ?? '',
      meta: json['meta'] != null ? OptionMeta.fromJson(json['meta']) : null,
    );
  }
}
class OptionMeta {
  final String? hex;
  final String? swatchUrl;

  OptionMeta({
    this.hex,
    this.swatchUrl,
  });

  factory OptionMeta.fromJson(Map<String, dynamic> json) {
    return OptionMeta(
      hex: json['hex'],
      swatchUrl: json['swatch_url'],
    );
  }
}
