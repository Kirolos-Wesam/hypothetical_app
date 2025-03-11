import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_firestore_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthDatasources {
  Future<User> login(LoginParams params);
  Future<User> createAccount(CreateAccountParams params);
  Future<void> storeUserAccount(CreateAccountFireStoreParams params);
}

class AuthDatasourcesImpl implements AuthDatasources {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthDatasourcesImpl({
    required this.firebaseAuth,
  });

  @override
  Future<User> login(LoginParams params) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
            email: params.email, password: params.password);
    return userCredential.user!;
  }

  @override
  Future<User> createAccount(CreateAccountParams params) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: params.email, password: params.password);
    return userCredential.user!;
  }

  @override
  Future<void> storeUserAccount(CreateAccountFireStoreParams params) async {
    await _firestore.collection('Users').doc(params.userId).set({
      'id': params.userId,
      'user_name': params.userName,
      'email': params.email,
      'phone_number': params.phoneNumber,
      'birth_date': params.dateOfBirth,
      'createdAt': FieldValue.serverTimestamp()
    });
  }
}
