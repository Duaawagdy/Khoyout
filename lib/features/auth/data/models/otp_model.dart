// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OtpModel {
  String? email;
  String? otp;
  //String? secretKey;
  OtpModel({
    this.email,
    this.otp,
  });


  OtpModel copyWith({
    String? email,
    String? otp,
  }) {
    return OtpModel(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'otp': otp,
    };
  }

  factory OtpModel.fromMap(Map<String, dynamic> map) {
    return OtpModel(
      email: map['email'] != null ? map['email'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpModel.fromJson(String source) => OtpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OtpModel(email: $email, otp: $otp)';

  @override
  bool operator ==(covariant OtpModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.otp == otp;
  }

  @override
  int get hashCode => email.hashCode ^ otp.hashCode;
}
