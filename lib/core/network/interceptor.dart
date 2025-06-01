import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/network/api_providers.dart';
import 'package:flutter_riverpod_best_practices/core/network/token_manager.dart';

class AppInterceptor extends Interceptor {
  final Ref ref;

  AppInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await ref.read(tokenManagerProvider).getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !err.requestOptions.extra.containsKey("retry")) {
      try {
        final newToken = await ref.read(tokenManagerProvider).refreshAccessToken();

        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';
        requestOptions.extra['retry'] = true;

        final dio = ref.read(dioProvider);
        final res = await dio.fetch(requestOptions);
        return handler.resolve(res);
      } catch (_) {
        // Refresh failed, let error pass
      }
    }

    handler.next(err);
  }
}
