class ResetPasswordRequest {
  final String email;
  final String resetKey;
  final String newPassword;
  final String newPasswordConfirmation;

  ResetPasswordRequest({
    required this.email,
    required this.resetKey,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'reset_key': resetKey,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };
  }

  // Optional: factory constructor to create from JSON if needed
  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      email: json['email'],
      resetKey: json['reset_key'],
      newPassword: json['new_password'],
      newPasswordConfirmation: json['new_password_confirmation'],
    );
  }
}
