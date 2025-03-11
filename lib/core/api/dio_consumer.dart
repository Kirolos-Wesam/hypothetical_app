import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../manager/strings_manager.dart';
import '/core/api/api_consumer.dart';
import '../errors/exceptions.dart';
import 'app_interceptor.dart';
import 'status_code.dart';
import '../src/injection_container.dart' as di;
class DioConsumer implements ApiConsumer {
  final Dio dio;
  late CancelToken cancelToken;

  DioConsumer({required this.dio, required String baseUrl}) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
    if (kDebugMode) {
      dio.interceptors.add(di.diInstance<AppInterceptors>());
      dio.interceptors.add(di.diInstance<LogInterceptor>());
    }
  }

  @override
  Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    try {
      log(url);
      cancelToken = CancelToken();
      return await dio.get(url,
          queryParameters: query, cancelToken: cancelToken);
    } on DioException catch (e) {
      log(e.toString());
      throw _handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    cancelToken = CancelToken();
    try {
      return await dio.post(url,
          queryParameters: query, data: data, cancelToken: cancelToken);
    } on DioException catch (e) {
      throw _handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    cancelToken = CancelToken();
    try {
      return await dio.put(url,
          queryParameters: query, data: data, cancelToken: cancelToken);
    } on DioException catch (e) {
      throw _handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    cancelToken = CancelToken();
    try {
      return await dio.patch(url, data: data, cancelToken: cancelToken);
    } on DioException catch (e) {
      throw _handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    cancelToken = CancelToken();

    try {
      return await dio.delete(url, data: data, cancelToken: cancelToken);
    } on DioException catch (e) {
      throw _handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  dynamic _handelDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException(error.response!.data['message']);
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(error.response!.data['status_message']);
          case StatusCode.notFound:
            throw NotFoundException(error.response!.data['message']);
          case StatusCode.conflict:
            throw const ConflictException(/*error.response!.data['message']*/);
          case StatusCode.internalServer:
            throw const InternalServerErrorException();
          default:
            throw ServerException(error.response!.data['message']);
        }
      case DioExceptionType.cancel:
        throw const ServerException('Canceled');

      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
      default:
        return null;
    }
  }

  @override
  void cancelRequest() {
    if (cancelToken.isCancelled) {
      return;
    }
    cancelToken.cancel();
  }
}
