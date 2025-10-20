import 'package:dio/dio.dart';
import 'api_error_model.dart';
import 'error_constants.dart';

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else {
      apiErrorModel = ApiErrorModel(
        statusCode: error.response?.data?['statusCode'] ?? ResponseMessage.DEFAULT,
        message: error.response?.data?['message'] ?? ResponseMessage.DEFAULT,
        errors: const [],
      );
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return _dataSourceToError(DataSource.CONNECT_TIMEOUT);

    case DioExceptionType.sendTimeout:
      return _dataSourceToError(DataSource.SEND_TIMEOUT);

    case DioExceptionType.receiveTimeout:
      return _dataSourceToError(DataSource.RECIEVE_TIMEOUT);

    case DioExceptionType.cancel:
      return _dataSourceToError(DataSource.CANCEL);

    case DioExceptionType.connectionError:
      return _dataSourceToError(DataSource.NO_INTERNET_CONNECTION);

    case DioExceptionType.badResponse:
      final data = error.response?.data;
      // لو الـ response فيه body JSON نرجعه زي ما هو
      if (data is Map<String, dynamic>) {
        return ApiErrorModel.fromJson(data);
      }
      final statusCode = error.response?.statusCode ?? 0;
      // لو مفيش body أو مش JSON، نعتمد على status code
      switch (statusCode) {
        case ResponseCode.BAD_REQUEST:
          return _dataSourceToError(DataSource.BAD_REQUEST);
        case ResponseCode.UNAUTORISED:
          return _dataSourceToError(DataSource.UNAUTORISED);
        case ResponseCode.FORBIDDEN:
          return _dataSourceToError(DataSource.FORBIDDEN);
        case ResponseCode.NOT_FOUND:
          return _dataSourceToError(DataSource.NOT_FOUND);
        case ResponseCode.INTERNAL_SERVER_ERROR:
          return _dataSourceToError(DataSource.INTERNAL_SERVER_ERROR);
        case ResponseCode.NO_CONTENT:
          return _dataSourceToError(DataSource.NO_CONTENT);
        default:
          return ApiErrorModel(
            statusCode: statusCode,
            message: error.response?.data?['message'] ?? ResponseMessage.DEFAULT,
            errors: const [],
          );
      }

    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return _dataSourceToError(DataSource.DEFAULT);
  }
}

ApiErrorModel _dataSourceToError(DataSource source) {
  switch (source) {
    case DataSource.NO_CONTENT:
      return ApiErrorModel(
        statusCode: ResponseCode.NO_CONTENT,
        message: ResponseMessage.NO_CONTENT,
        errors: const [],
      );

    case DataSource.BAD_REQUEST:
      return ApiErrorModel(
        statusCode: ResponseCode.BAD_REQUEST,
        message: ResponseMessage.BAD_REQUEST,
        errors: const [],
      );

    case DataSource.UNAUTORISED:
      return ApiErrorModel(
        statusCode: ResponseCode.UNAUTORISED,
        message: ResponseMessage.UNAUTORISED,
        errors: const [],
      );

    case DataSource.FORBIDDEN:
      return ApiErrorModel(
        statusCode: ResponseCode.FORBIDDEN,
        message: ResponseMessage.FORBIDDEN,
        errors: const [],
      );

    case DataSource.NOT_FOUND:
      return ApiErrorModel(
        statusCode: ResponseCode.NOT_FOUND,
        message: ResponseMessage.NOT_FOUND,
        errors: const [],
      );

    case DataSource.INTERNAL_SERVER_ERROR:
      return ApiErrorModel(
        statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
        message: ResponseMessage.INTERNAL_SERVER_ERROR,
        errors: const [],
      );

    case DataSource.CONNECT_TIMEOUT:
      return ApiErrorModel(
        statusCode: ResponseCode.CONNECT_TIMEOUT,
        message: ResponseMessage.CONNECT_TIMEOUT,
        errors: const [],
      );

    case DataSource.CANCEL:
      return ApiErrorModel(
        statusCode: ResponseCode.CANCEL,
        message: ResponseMessage.CANCEL,
        errors: const [],
      );

    case DataSource.RECIEVE_TIMEOUT:
      return ApiErrorModel(
        statusCode: ResponseCode.RECIEVE_TIMEOUT,
        message: ResponseMessage.RECIEVE_TIMEOUT,
        errors: const [],
      );

    case DataSource.SEND_TIMEOUT:
      return ApiErrorModel(
        statusCode: ResponseCode.SEND_TIMEOUT,
        message: ResponseMessage.SEND_TIMEOUT,
        errors: const [],
      );

    case DataSource.NO_INTERNET_CONNECTION:
      return ApiErrorModel(
        statusCode: ResponseCode.NO_INTERNET_CONNECTION,
        message: ResponseMessage.NO_INTERNET_CONNECTION,
        errors: const [],
      );

    case DataSource.CACHE_ERROR:
      return ApiErrorModel(
        statusCode: ResponseCode.CACHE_ERROR,
        message: ResponseMessage.CACHE_ERROR,
        errors: const [],
      );

    case DataSource.DEFAULT:
      return ApiErrorModel(
        statusCode: ResponseCode.DEFAULT,
        message: ResponseMessage.DEFAULT,
        errors: const [],
      );
  }
}
