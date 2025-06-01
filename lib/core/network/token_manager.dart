import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod_best_practices/core/common/providers/secure_storage_provider.dart';
import 'package:flutter_riverpod_best_practices/core/network/api_providers.dart';

class TokenManager {
  final FlutterSecureStorage storage;
  final Dio authDio;
  Completer<String?>? _refreshCompleter;

  TokenManager({required this.storage, required this.authDio});

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future<int?> getUserId() async {
    final String? usrId = await storage.read(key: 'userId');
    return usrId == null ? null : int.parse(usrId);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refreshToken');
  }

    Future<String?> getPhoneNumber() async {
    return await storage.read(key: 'phoneNumber');
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    await storage.write(key: 'phoneNumber', value: phoneNumber);
  }

  Future<void> saveTokens(
    int userId,
    String accessToken,
    String refreshToken,
  ) async {
    await storage.write(key: 'userId', value: "$userId");
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> clearTokens() async {
    await storage.deleteAll();
  }

  Future<String?> refreshAccessToken() async {
    if (_refreshCompleter != null) return _refreshCompleter!.future;

    _refreshCompleter = Completer();

    try {
      final refreshToken = await getRefreshToken();
      final userId = await getUserId();
      if (refreshToken == null) throw Exception("No refresh token");
      if (userId == null) throw Exception("No User Id");

      final res = await authDio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken, 'userId': userId},
      );

      final newAccessToken = res.data['data']['accessToken'];
      //final newRefreshToken = res.data['data']['refreshToken'];

      await saveTokens(userId,newAccessToken, refreshToken);
      _refreshCompleter?.complete(newAccessToken);
      return newAccessToken;
    } catch (e) {
      _refreshCompleter?.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }
}

final tokenManagerProvider = Provider((ref) {
  return TokenManager(
    storage: ref.read(secureStorageProvider),
    authDio: ref.read(authDioProvider),
  );
});
