// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiErrorModel {
  final String? message;
  final int? code;

  final Map<String, dynamic>? errors;
  ApiErrorModel({
    this.message,
    this.code,
    this.errors,
  });

  ApiErrorModel copyWith({
    String? message,
    int? code,
    Map<String, dynamic>? errors,
  }) {
    return ApiErrorModel(
      message: message ?? this.message,
      code: code ?? this.code,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'errors': errors,
    };
  }

  factory ApiErrorModel.fromMap(Map<String, dynamic> map) {
    return ApiErrorModel(
      message: map['message'] != null ? map['message'] as String : null,
      code: map['code'] != null ? map['code'] as int : null,
      errors: map['errors'] != null
          ? Map<String, dynamic>.from((map['errors'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiErrorModel.fromJson(String source) =>
      ApiErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ApiErrorModel(message: $message, code: $code, errors: $errors)';

  @override
  bool operator ==(covariant ApiErrorModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.code == code &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ errors.hashCode;
}
