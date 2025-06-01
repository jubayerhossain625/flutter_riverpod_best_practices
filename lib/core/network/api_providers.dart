import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod_best_practices/core/network/interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_client.dart';
import 'api_service.dart';

final authDioProvider = Provider<Dio>( //for only refresh token
  (_) => Dio(BaseOptions(baseUrl: 'https://api.your_domain.com/flutter_best_practicce/api')),
); // No interceptor to avoid loops during token refresh
final dioProvider = Provider<Dio>((ref) { //for apis
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.your_domain.com/flutter_best_practicce/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    AppInterceptor(ref),
  ); // Add your custom interceptor first
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
      filter: (options, args) {
        // Filter out requests/responses for cleaner logs
        if (options.path.contains('/posts')) {
          return false;
        }
        return !args.isResponse || !args.hasUint8ListData;
      },
    ),
  );

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dioProvider));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.read(apiClientProvider));
});
