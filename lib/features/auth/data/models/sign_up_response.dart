// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpResponse {
  String? message;

String? email;

  SignUpResponse({
    this.message,
this.email

  });
  

  SignUpResponse copyWith({
    String? message,

  }) {
    return SignUpResponse(
      message: message ?? this.message,


    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,

    };
  }

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
      message: map['message'] != null ? map['message'] as String : null,
      email:map['data']['email']

    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponse.fromJson(String source) => SignUpResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpResponse(message: $message)';
  }

  @override
  bool operator ==(covariant SignUpResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;

  }

  @override
  int get hashCode {
    return message.hashCode
      ;
  }
}
