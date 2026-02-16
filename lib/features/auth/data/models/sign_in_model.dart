import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInModel {
  final String email;

  final String password;
  SignInModel({
    required this.email,

    required this.password,
  });

  SignInModel copyWith({
    String? email,
    String? username,
    String? password,
  }) {
    return SignInModel(
      email: email ?? this.email,

      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,

      'password': password,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      email: map['email'] as String,

      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory SignInModel.fromJson(String source) =>
  //     SignInModel.fromMap(json.decode(source) as Map<String, dynamic>);
  //
  // @override
  // String toString() => 'SignInModel(email: $email, username: $username, password: $password)';
  //
  // @override
  // bool operator ==(covariant SignInModel other) {
  //   if (identical(this, other)) return true;
  //
  //   return other.email == email && other.username == username && other.password == password;
  // }
  //
  // @override
  // int get hashCode => email.hashCode ^ username.hashCode ^ password.hashCode;
}
