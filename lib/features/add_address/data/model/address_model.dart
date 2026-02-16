class AddressesModel {
  final int id;
  final int? userId;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String buildingNumber;
  final String? apartmentNumber;
  final String? floorNumber;
  final String phoneNumber;
  final String? locationUrl;
  final dynamic isDefault;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressesModel({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.buildingNumber,
    this.apartmentNumber,
    this.floorNumber,
    required this.phoneNumber,
    this.locationUrl,
    required this.isDefault,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressesModel.fromJson(Map<String, dynamic> json) {
    return AddressesModel(
      id: json['id'],
      userId: json['user_id']??0,
      street: json['street']??'',
      city: json['city']??'',
      state: json['state']??'',
      country: json['country']??'',
      postalCode: json['postal_code']??'',
      buildingNumber: json['building_number']??'',
      apartmentNumber: json['apartment_number']??'',
      floorNumber: json['floor_number']??'',
      phoneNumber: json['phone_number']??'',
      locationUrl: json['location_url']??'',
      isDefault: json['is_default']??0 ,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "street": street,
      "city": city,
      "state": state,
      "country": country,
      "postal_code": postalCode,
      "building_number": buildingNumber,
      "apartment_number": apartmentNumber,
      "floor_number": floorNumber,
      "phone_number": phoneNumber,
      "location_url": locationUrl,
      "is_default": isDefault,
      "latitude": latitude,
      "longitude": longitude,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
