part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}

class CreateAccountLoadingState extends AuthState {}

class CreateAccountSuccessState extends AuthState {
  final String createAccountId;

  CreateAccountSuccessState(this.createAccountId);
}

class CreateAccountErrorState extends AuthState {
  final String error;

  CreateAccountErrorState(this.error);
}

class CreateAccountFireStoreLoadingState extends AuthState {}

class CreateAccountFireStoreSuccessState extends AuthState {}

class CreateAccountFireStoreErrorState extends AuthState {
  final String error;

  CreateAccountFireStoreErrorState(this.error);
}
