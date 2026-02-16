class AddAddressModel {
  final String street;
  final String city;
  final String country;
  final String buildingNumber;
  final String? apartmentNumber;
  final String? floorNumber;
  final String phoneNumber;
  final String? locationUrl;
  final int isDefault;
  final double? latitude;
  final double? longitude;

  AddAddressModel({
    required this.street,
    required this.city,
    required this.country,
    required this.buildingNumber,
    this.apartmentNumber,
    this.floorNumber,
    required this.phoneNumber,
    this.locationUrl,
    required this.isDefault,
    this.latitude,
    this.longitude,
  });

  factory AddAddressModel.fromJson(Map<String, dynamic> json) {
    return AddAddressModel(
      street: json['street'],
      city: json['city'],
      country: json['country'],
      buildingNumber: json['building_number'],
      apartmentNumber: json['apartment_number'],
      floorNumber: json['floor_number'],
      phoneNumber: json['phone_number'],
      locationUrl: json['location_url'],
      isDefault: json['is_default'],
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "country": country,
      "building_number": buildingNumber,
      "apartment_number": apartmentNumber,
      "floor_number": floorNumber,
      "phone_number": phoneNumber,
      "location_url": locationUrl,
      "is_default": isDefault,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
