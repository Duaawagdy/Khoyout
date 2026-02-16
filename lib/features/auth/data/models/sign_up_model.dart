import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpModel {
  final String name;
  final String email;
  final String password;
  const SignUpModel({
    required this.name,
    required this.email,
    required this.password,
  });

  SignUpModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return SignUpModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) => SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignUpModel(name: $name, email: $email, password: $password)';

  @override
  bool operator ==(covariant SignUpModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;
}
