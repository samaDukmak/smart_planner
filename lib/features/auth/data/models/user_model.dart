// features/Auth/data/models/user_model.dart
class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? json;
    return UserModel(
      id: user['id'],
      name: user['user_name'],
      email: user['email'],
      token: json['token'] ?? '', // ملاحظ: token خارج user
    );
  }
}
