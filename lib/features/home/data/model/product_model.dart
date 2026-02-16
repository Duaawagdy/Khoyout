class ProductModel {
   final int? id;
   final String? uuid;
   final String? name;
   final String? slug;
   final String? description;
   final String? descriptionAr;
   final bool inCart;
    int cartQuantity;
   final CategoryModel? category;
    bool isFavorite;
   final List<String> images;
   final String? firstImage;
   final List<ColorModel> colors;
   final List<dynamic> sizes;
   final num basePrice;
   final num? discountPrice;
   final List<VariantModel> variants;

   ProductModel({
      this.id,
      this.uuid,
      this.name,
      this.slug,
      this.description,
      this.descriptionAr,
      required this.inCart,
      required this.cartQuantity,
      this.category,
      required this.isFavorite,
      required this.images,
      this.firstImage,
      required this.colors,
      required this.sizes,
      required this.basePrice,
      this.discountPrice,
      required this.variants,
   });

   factory ProductModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) {
         return ProductModel(
            inCart: false,
            cartQuantity: 0,
            isFavorite: false,
            images: [],
            colors: [],
            sizes: [],
            basePrice: 0,
            variants: [],
         );
      }

      return ProductModel(
         id: json['id'],
         uuid: json['uuid'],
         name: json['name'],
         slug: json['slug'],
         description: json['description'],
         descriptionAr: json['description_ar'],
         inCart: json['in_cart'] ?? false,
         cartQuantity: json['cart_quantity'] ?? 0,
         category: json['category'] != null
             ? CategoryModel.fromJson(json['category'])
             : null,
         isFavorite: json['is_favorite'] ?? false,
         images: List<String>.from(json['images'] ?? []),
         firstImage: json['first_image'],
         colors: (json['colors'] as List? ?? [])
             .map((e) => ColorModel.fromJson(e))
             .toList(),
         sizes: json['sizes'] ?? [],
         basePrice: json['base_price'] ?? 0,
         discountPrice: json['discount_price'],
         variants: (json['variants'] as List? ?? [])
             .map((e) => VariantModel.fromJson(e))
             .toList(),
      );
   }
}


class CategoryModel {
   final int? id;
   final String? name;
   final String? slug;
   final String? description;
   final String? descriptionAr;

   CategoryModel({
      this.id,
      this.name,
      this.slug,
      this.description,
      this.descriptionAr,
   });

   factory CategoryModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) return CategoryModel();

      return CategoryModel(
         id: json['id'],
         name: json['name'],
         slug: json['slug'],
         description: json['description'],
         descriptionAr: json['description_ar'],
      );
   }
}

class ColorModel {
   final int? id;
   final String? name;
   final String? hex;
   final String? swatchUrl;
   final bool available;

   ColorModel({
      this.id,
      this.name,
      this.hex,
      this.swatchUrl,
      required this.available,
   });

   factory ColorModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) {
         return ColorModel(available: false);
      }

      return ColorModel(
         id: json['id'],
         name: json['name'],
         hex: json['hex'],
         swatchUrl: json['swatch_url'],
         available: json['available'] ?? false,
      );
   }
}

class VariantModel {
   final int? id;
   final String? sku;
   final num price;
   final int stock;
   final String? stockStatus;
   final String? image;
   final List<VariantOptionModel> options;
   final String? summary;

   VariantModel({
      this.id,
      this.sku,
      required this.price,
      required this.stock,
      this.stockStatus,
      this.image,
      required this.options,
      this.summary,
   });

   factory VariantModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) {
         return VariantModel(
            price: 0,
            stock: 0,
            options: [],
         );
      }

      return VariantModel(
         id: json['id'],
         sku: json['sku'],
         price: json['price'] ?? 0,
         stock: json['stock'] ?? 0,
         stockStatus: json['stock_status'],
         image: json['image'],
         options: (json['options'] as List? ?? [])
             .map((e) => VariantOptionModel.fromJson(e))
             .toList(),
         summary: json['summary'],
      );
   }
}

class VariantOptionModel {
   final String? option;
   final String? value;
   final String? valueAr;
   final VariantMetaModel? meta;

   VariantOptionModel({
      this.option,
      this.value,
      this.valueAr,
      this.meta,
   });

   factory VariantOptionModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) return VariantOptionModel();

      return VariantOptionModel(
         option: json['option'],
         value: json['value'],
         valueAr: json['value_ar'],
         meta: VariantMetaModel.fromJson(json['meta']),
      );
   }
}

class VariantMetaModel {
   final String? hex;
   final String? swatchUrl;

   VariantMetaModel({
      this.hex,
      this.swatchUrl,
   });

   factory VariantMetaModel.fromJson(Map<String, dynamic>? json) {
      if (json == null) return VariantMetaModel();

      return VariantMetaModel(
         hex: json['hex'],
         swatchUrl: json['swatch_url'],
      );
   }
}


