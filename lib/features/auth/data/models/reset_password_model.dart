// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPasswordModel {
  String? password;
  String? email;
  String? secretKey;
  ResetPasswordModel({
    this.password,
    this.email,
    this.secretKey,
  });

  ResetPasswordModel copyWith({
    String? password,
    String? email,
    String? secretKey,
  }) {
    return ResetPasswordModel(
      password: password ?? this.password,
      email: email ?? this.email,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_password': password,
      'email': email,
      'secret_key': secretKey,
    };
  }

  factory ResetPasswordModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordModel(
      password: map['new_password'] != null ? map['new_password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      secretKey: map['secret_key'] != null ? map['secret_key'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordModel.fromJson(String source) => ResetPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPasswordModel(new_password: $password, email: $email, secret_key: $secretKey)';

  @override
  bool operator ==(covariant ResetPasswordModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.password == password &&
      other.email == email &&
      other.secretKey == secretKey;
  }

  @override
  int get hashCode => password.hashCode ^ email.hashCode ^ secretKey.hashCode;
}
