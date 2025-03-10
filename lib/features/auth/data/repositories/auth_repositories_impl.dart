import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/features/auth/data/datasources/auth_datasources.dart';

import 'package:hypothetical_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthDatasources _authDatasources;

  AuthRepositoriesImpl({required AuthDatasources authDatasources})
      : _authDatasources = authDatasources;

  @override
  Future<User> login(LoginParams params) async {
    late User user;
    user = await _authDatasources.login(params);
    return user;
  }

  @override
  Future<User> createAccount(CreateAccountParams params) async {
    late User user;
    user = await _authDatasources.createAccount(params);
    return user;
  }
}
