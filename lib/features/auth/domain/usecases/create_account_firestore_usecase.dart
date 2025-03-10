import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/core/usecases/base_usecase.dart';
import 'package:hypothetical_app/core/usecases/firebase_try_catch.dart';
import 'package:hypothetical_app/features/auth/domain/repositories/auth_repositories.dart';

import '../../../../core/errors/failure.dart';

class CreateAccountFirestoreUseCase
    extends BaseUseCase<void, CreateAccountFireStoreParams> {
  final AuthRepositories _authRepositories;

  CreateAccountFirestoreUseCase(this._authRepositories);

  @override
  Future<Either<Failure, void>> call(
          CreateAccountFireStoreParams params) async =>
      await firebaseAuthTryCatch(
        tryFunction: () => _authRepositories.createAccountFireStore(params),
      );
}

class CreateAccountFireStoreParams extends Equatable {
  final String email;
  final String userId;
  final String? userName;
  final String? phoneNumber;
  final String? dateOfBirth;

  CreateAccountFireStoreParams(
      {required this.email,
      required this.userId,
      this.userName,
      this.phoneNumber,
      this.dateOfBirth});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [email, userName, phoneNumber, dateOfBirth, userId];
}
