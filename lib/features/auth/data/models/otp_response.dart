// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OtpResponse {
  String? message;
  String? secretKey;
  OtpResponse({
    this.message,
    this.secretKey,
  });

  OtpResponse copyWith({
    String? message,
    String? secretKey,
  }) {
    return OtpResponse(
      message: message ?? this.message,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'secret_key': secretKey,
    };
  }

  factory OtpResponse.fromMap(Map<String, dynamic> map) {
    return OtpResponse(
      message: map['message'] != null ? map['message'] as String : null,
      secretKey: map['secret_key'] != null ? map['secret_key'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpResponse.fromJson(String source) => OtpResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OtpResponse(message: $message, secret_key: $secretKey)';

  @override
  bool operator ==(covariant OtpResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.secretKey == secretKey;
  }

  @override
  int get hashCode => message.hashCode ^ secretKey.hashCode;
}
