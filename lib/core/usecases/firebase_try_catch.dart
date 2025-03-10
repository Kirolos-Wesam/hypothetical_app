import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/core/errors/exceptions.dart';
import 'package:hypothetical_app/core/errors/failure.dart';

Future<Either<Failure, T>> firebaseAuthTryCatch<T>(
    {required Future<T> Function() tryFunction}) async {
  try {
    return Right(await tryFunction());
  } on FirebaseAuthException catch (e, stack) {
    Completer().completeError(e, stack);
    return Left(ServerFailure(e.message));
  } on CacheException catch (e, stack) {
    Completer().completeError(e, stack);
    return Left(CacheFailure(e.message));
  }
}
