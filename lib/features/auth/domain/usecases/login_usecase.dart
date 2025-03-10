import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/core/usecases/base_usecase.dart';
import 'package:hypothetical_app/core/usecases/try_catch.dart';
import 'package:hypothetical_app/features/auth/domain/repositories/auth_repositories.dart';

import '../../../../core/errors/failure.dart';

class LoginUseCase extends BaseUseCase<User, LoginParams> {
  final AuthRepositories _authRepositories;

  LoginUseCase(this._authRepositories);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async =>
      await tryCatch(
        tryFunction: () => _authRepositories.login(params),
      );
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
