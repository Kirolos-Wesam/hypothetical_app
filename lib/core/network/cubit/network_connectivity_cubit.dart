import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityCubit extends Cubit<bool> {
  StreamSubscription? _subscription;
  NetworkConnectivityCubit() : super(true);

  static NetworkConnectivityCubit get(context) => BlocProvider.of(context);

  void checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    emit(result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile);
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
          emit(result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile);
        } as void Function(List<ConnectivityResult> event)?);
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
