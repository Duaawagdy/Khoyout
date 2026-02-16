// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignInResponse {
  final String? token;
  final String? name;
  final String? email;
  SignInResponse({
    this.token,
    this.name,
    this.email,
  });



  SignInResponse copyWith({
    String? token,
    String? name,
    String? userNicename,
  }) {
    return SignInResponse(
      token: token ?? this.token,
      name: name ?? this.name,
      email: userNicename ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'name': name,
      'email': email,
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      token: map['token'] != null ? map['token'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponse.fromJson(String source) => SignInResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignInResponse(token: $token, name: $name, user_nicename: $email)';

  @override
  bool operator ==(covariant SignInResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => token.hashCode ^ name.hashCode ^ email.hashCode;
}
