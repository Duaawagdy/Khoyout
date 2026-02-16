class ReviewsResponse {
  final bool success;
  final List<Review> data;
  final Meta meta;

  ReviewsResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ReviewsResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
}
class Review {
  final int id;
  final int userId;
  final String type;
  final String message;
  final String status;
  final String? adminNotes;
  final String createdAt;
  final String updatedAt;
  final int? orderId;
  final int? productId;
  final int? orderItemId;
  final int? rating;
  final String? title;
  final ReviewUser? user;

  Review({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.status,
    this.adminNotes,
    required this.createdAt,
    required this.updatedAt,
    this.orderId,
    this.productId,
    this.orderItemId,
    this.rating,
    this.title,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      adminNotes: json['admin_notes'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      orderId: json['order_id'],
      productId: json['product_id'],
      orderItemId: json['order_item_id'],
      rating: json['rating'],
      title: json['title'],
      user: json['user'] != null
          ? ReviewUser.fromJson(json['user'])
          : null,
    );
  }
}
class ReviewUser {
  final int id;
  final String name;

  ReviewUser({
    required this.id,
    required this.name,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
class Meta {
  final int currentPage;
  final int total;
  final int perPage;
  final int lastPage;

  Meta({
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 10,
      lastPage: json['last_page'] ?? 1,
    );
  }
}
