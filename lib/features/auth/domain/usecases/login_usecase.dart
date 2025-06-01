import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<AppException, LoginDataModel>> execute(String phone) {
    return repository.login(phone);
  }
}

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});
