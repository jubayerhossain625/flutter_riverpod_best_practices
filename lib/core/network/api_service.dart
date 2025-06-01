import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../error/app_exception.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  Future<Response<T>> _safeApiCall<T>(
    Future<Response<T>> Function() apiCall,
  ) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const AppException.network();
      }

      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response?.data['message'] ?? 'Something went wrong';

        switch (statusCode) {
          case 400:
            throw AppException.badRequest(message);
          case 401:
            throw AppException.unauthorized(message);
          case 500:
            throw AppException.server(message);
          default:
            throw AppException.unknown(message);
        }
      } else {
        throw AppException.unknown(e.message ?? 'Unknown error');
      }
    } catch (e) {
      throw AppException.unknown(e.toString());
    }
  }

  Future<Either<AppException, Map<String, dynamic>>> postRequest(
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _safeApiCall(
        () =>
            _apiClient.post(path, data: data, queryParameters: queryParameters),
      );
      return right(res.data['data']);
    } catch (e) {
      if (e is AppException) {
        return left(e);
      } else {
        return left(AppException.unknown(e.toString()));
      }
    }
  }

  Future<Either<AppException, Map<String, dynamic>>> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _safeApiCall(
        () => _apiClient.get(path, queryParameters: queryParameters),
      );
      return right(res.data['data']);
    } catch (e) {
      if (e is AppException) {
        return left(e);
      } else {
        return left(AppException.unknown(e.toString()));
      }
    }
  }

  // Future<Either<AppException, Map<String, dynamic>>> postMultipartRequest(
  //   String path, {
  //   required Map<String, dynamic> fields,
  //   Map<String, dynamic>? queryParameters,
  //   Map<String, String> imagePaths = const {},
  // }) async {
  //   try {
  //     Map<String, MultipartFile> imageFiles = {};
  //     if (imagePaths.isNotEmpty) {
  //       for (var i = 0; i < imagePaths.length; i++) {
  //         final file = await MultipartFile.fromFile(
  //           imagePaths.entries.elementAt(i).value,
  //           filename: imagePaths.entries.elementAt(i).key,
  //         );
  //         imageFiles["userPhoto"] = file;
  //       } //MultipartFile.fromFile(path, filename: filename ?? path.split('/').last);
  //     }
  //     final formData = FormData.fromMap({
  //       ...fields,
  //       if (imageFiles.isNotEmpty) ...imageFiles,
  //     });

  //     final res = await _safeApiCall(
  //       () => _apiClient.postMultipart(
  //         path,
  //         data: formData,
  //         queryParameters: queryParameters,
  //       ),
  //     );

  //     return right(res.data['data']);
  //   } catch (e) {
  //     if (e is AppException) {
  //       return left(e);
  //     } else {
  //       return left(AppException.unknown(e.toString()));
  //     }
  //   }
  // }

  Future<Either<AppException, Map<String, dynamic>>> postMultipartRequest(
    String path, {
    required List<File> files,
    required String fileKey, // use 'userPhoto' for single image
    Map<String, dynamic>? fields,
  }) async {
    try {
      // Validate and prepare MultipartFiles
      final List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        final fileName = file.path.split('/').last;
        final fileExtension = fileName.split('.').last.toLowerCase();

        if (!['png', 'jpg', 'jpeg'].contains(fileExtension)) {
          return left(
            AppException.badRequest(
              'Invalid image type. Only PNG, JPG, JPEG allowed.',
            ),
          );
        }

        final mimeType = _getMimeType(fileExtension);

        multipartFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // Build form data
      final formData = FormData.fromMap({
        if (fields != null) ...fields,
        if (files.length == 1)
          fileKey: multipartFiles.first
        else
          fileKey: multipartFiles,
      });

      final response = await _safeApiCall(
        () => _apiClient.postMultipart(path, data: formData),
      );

      return right(response.data['data']);
    } catch (e) {
      if (e is AppException) {
        return left(e);
      } else {
        return left(AppException.unknown(e.toString()));
      }
    }
  }

  String _getMimeType(String extension) {
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      default:
        return 'application/octet-stream';
    }
  }
}
