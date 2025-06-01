import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_provider.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final FlutterSecureStorage storage;

  AuthNotifier({required this.storage}) : super(AuthStatus.loading) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {

    await Future.delayed(Duration(seconds: 3)); // simulate delay
    // Check storage, token, etc.
    final userId = await getUserId();
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    state =
        (userId != null && accessToken != null && refreshToken != null)
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;
  }

  void saveLogin({
    required int userId,
    required String accessToken,
    required String refreshToken,
    required String phoneNumber,
  }) {
    saveTokens(userId, accessToken, refreshToken);
    savePhoneNumber(phoneNumber);

    state = AuthStatus.authenticated;
  }

  void logout() {
    clearTokens();
    state = AuthStatus.unauthenticated;
  }

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

  Future<void> savePhoneNumber(String phoneNumber) async {
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
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((
  ref,
) {
  return AuthNotifier(storage: ref.read(secureStorageProvider));
});
