import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthDatasources {
  Future<User> login(LoginParams params);
  Future<User> createAccount(CreateAccountParams params);
}

class AuthDatasourcesImpl implements AuthDatasources {
  get firebaseAuth => null;

  @override
  Future<User> login(LoginParams params) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
            email: params.email, password: params.password);
    return userCredential.user!;
  }

  @override
  Future<User> createAccount(CreateAccountParams params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
