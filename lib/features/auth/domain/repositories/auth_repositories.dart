import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_firestore_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthRepositories {
  Future<User> login(LoginParams params);
  Future<User> createAccount(CreateAccountParams params);
  Future<void> createAccountFireStore(CreateAccountFireStoreParams params);
}
