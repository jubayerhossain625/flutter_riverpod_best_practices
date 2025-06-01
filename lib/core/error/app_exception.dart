import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.network() = NetworkException;
  const factory AppException.server(String message) = ServerException;
  const factory AppException.unauthorized(String message) =
      UnauthorizedException;
  const factory AppException.badRequest(String message) = BadRequestException;
  const factory AppException.unknown(String message) = UnknownException;
}

extension ExceptionPersing on AppException {
  String parseError() {
    return switch (this) {
      NetworkException() => 'No internet connection',
      ServerException(:final message) => message,
      UnauthorizedException(:final message) => message,
      BadRequestException(:final message) => message,
      UnknownException(:final message) => message,
    };
  }
}
