class ProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final AddressModel? defaultAddress;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.defaultAddress,
  });

  factory ProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProfileModel();

    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      defaultAddress: json['default_address'] != null
          ? AddressModel.fromJson(json['default_address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'default_address': defaultAddress?.toJson(),
    };
  }
}
class AddressModel {
  final int? id;
  final String? city;
  final String? area;
  final String? street;
  final String? building;

  AddressModel({
    this.id,
    this.city,
    this.area,
    this.street,
    this.building,
  });

  factory AddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AddressModel();

    return AddressModel(
      id: json['id'],
      city: json['city'],
      area: json['area'],
      street: json['street'],
      building: json['building'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'area': area,
      'street': street,
      'building': building,
    };
  }
}
