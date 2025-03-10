import 'package:hypothetical_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.userName,
      required super.phoneNumber,
      required super.email,
      required super.dateOfBirth});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        userName: json['userName'],
        phoneNumber: json['phoneNumber'],
        dateOfBirth: json['dateOfBirth'],
        email: json['email']);
  }
}
