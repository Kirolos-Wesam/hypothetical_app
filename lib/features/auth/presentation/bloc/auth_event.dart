part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;

  const CreateAccountEvent({
    required this.email,
    required this.password,
  });
}

class CreateAccountFireStoreEvent extends AuthEvent {
  final String email;
  final String userName;
  final String phoneNumber;
  final String useId;
  final String birthDate;

  const CreateAccountFireStoreEvent(
      {required this.email,
      required this.userName,
      required this.phoneNumber,
      required this.useId,
      required this.birthDate});
}
