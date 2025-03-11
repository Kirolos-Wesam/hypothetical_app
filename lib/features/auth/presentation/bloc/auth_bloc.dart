// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: void_checks

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypothetical_app/core/extensions/print_extension.dart';

import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';

import '../../domain/usecases/create_account_firestore_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final CreateAccountUseCase _createAccountUseCase;
  final CreateAccountFirestoreUseCase _createAccountFirestoreUseCase;

  AuthBloc(this._loginUseCase, this._createAccountUseCase,
      this._createAccountFirestoreUseCase)
      : super(AuthInitial()) {
    on<LoginEvent>(loginIn);
    on<CreateAccountEvent>(createAccount);
    on<CreateAccountFireStoreEvent>(createAccountFireStore);
  }

  static AuthBloc get(context) => BlocProvider.of<AuthBloc>(context);

  Future<void> loginIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password));
    result.fold((failure) {
      emit(LoginErrorState(failure.message!));
    }, (data) {
      emit(LoginSuccessState(data.uid));
    });
  }

  Future<void> createAccount(
      CreateAccountEvent event, Emitter<AuthState> emit) async {
    emit(CreateAccountLoadingState());
    final result = await _createAccountUseCase(
        CreateAccountParams(email: event.email, password: event.password));
    result.fold((failure) {
      emit(CreateAccountErrorState(failure.message!));
    }, (data) {
      emit(CreateAccountSuccessState(data.uid));
    });
  }

  Future<void> createAccountFireStore(
      CreateAccountFireStoreEvent event, Emitter<AuthState> emit) async {
    emit(CreateAccountFireStoreLoadingState());
    final result = await _createAccountFirestoreUseCase(
        CreateAccountFireStoreParams(
            email: event.email,
            userId: event.useId,
            userName: event.userName,
            dateOfBirth: event.birthDate,
            phoneNumber: event.phoneNumber));
    result.fold((failure) {
      emit(CreateAccountFireStoreErrorState(failure.message!));
    }, (data) {
      emit(CreateAccountFireStoreSuccessState());
    });
  }
}
