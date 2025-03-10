import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String userName;
  final String phoneNumber;
  final String email;
  final String dateOfBirth;

  const UserEntity(
      {required this.id,
      required this.userName,
      required this.phoneNumber,
      required this.email,
      required this.dateOfBirth});

  @override
  List<Object?> get props => [id, userName, phoneNumber, dateOfBirth, email];
}
