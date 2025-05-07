// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sample_app/core/utils/error_cubit.dart';
import 'package:sample_app/core/utils/error_logger.dart';

class HttpClient {
  HttpClient({required this.errorCubit}) {
    _dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      contentType: 'application/json',
    );

    // Add interceptor for error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          ErrorLogger.instance.logError(
            error: e.error,
            stackTrace: e.stackTrace,
            file: 'http_client',
            event: '${e.requestOptions.method} on ${e.requestOptions.path}',
          );
          errorCubit.showUnknownError();
          handler.reject(e);
        },
      ),
    );
  }
  late ErrorCubit errorCubit;
  late final Dio _dio = Dio();

  Future<dynamic> getRequest(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameter,
        options: Options(headers: headers ?? {}),
      );

      final data = res.data;

      if (data is List) {
        return data.map((e) => e as Map<String, dynamic>).toList();
      } else if (data is Map<String, dynamic>) {
        return data;
      } else if (data is String) {
        return json.decode(data);
      } else {
        return null;
      }
    } catch (error) {
      errorCubit.showUnknownError();
      return Future.error(error);
    }
  }
}
