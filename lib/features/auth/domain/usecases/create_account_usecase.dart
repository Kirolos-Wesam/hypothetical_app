import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/core/usecases/base_usecase.dart';
import 'package:hypothetical_app/core/usecases/try_catch.dart';
import 'package:hypothetical_app/features/auth/domain/repositories/auth_repositories.dart';

import '../../../../core/errors/failure.dart';

class CreateAccountUseCase extends BaseUseCase<User, CreateAccountParams> {
  final AuthRepositories _authRepositories;

  CreateAccountUseCase(this._authRepositories);

  @override
  Future<Either<Failure, User>> call(CreateAccountParams params) async =>
      await tryCatch(
        tryFunction: () => _authRepositories.createAccount(params),
      );
}

class CreateAccountParams extends Equatable {
  final String email;
  final String password;
  final String? userName;
  final String? phoneNumber;
  final String? dateOfBirth;

  CreateAccountParams(
      {required this.email,
      required this.password,
      required this.userName,
      required this.phoneNumber,
      required this.dateOfBirth});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [email, password, userName, phoneNumber, dateOfBirth];
}
