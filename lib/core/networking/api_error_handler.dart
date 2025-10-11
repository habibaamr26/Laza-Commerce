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
        responseCode:
            error.response?.data?['statusCode'] ?? ResponseMessage.DEFAULT,
        message: error.response?.data?['message'] ?? ResponseMessage.DEFAULT,
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
      final statusCode = error.response?.statusCode ?? ResponseCode.DEFAULT;
      Map<String, dynamic> data = error.response?.data["errors"];
      //{password: [Password must contain at least one uppercase letter., Password must contain at least one digit., Password must contain at least one special character.]}
      String? errors1;
      String? errors2;

      if (data != null) {
        if (data.containsKey('password')) {
          List<String> passwordErrors = List<String>.from(data['password']);
          errors1 = passwordErrors.join(', ');
          print(errors1);
        }

        if (data.containsKey('email')) {
          List<String> emailErrors = List<String>.from(data['email']);
          errors2 = emailErrors.join(', ');
          print(errors2);
        }
      }

      String detailedErrors = [
        if (errors1 != null) errors1,
        if (errors2 != null) errors2,
      ].join(' | ');

      switch (statusCode) {
        case ResponseCode.BAD_REQUEST:
          return ApiErrorModel(
            responseCode: statusCode,
            message:
            error.response?.data?['message'] ?? ResponseMessage.DEFAULT,
            errors: detailedErrors,
          );

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
            responseCode: statusCode,
            message:
                error.response?.data?['message'] ?? ResponseMessage.DEFAULT,
            errors: detailedErrors,
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
        responseCode: ResponseCode.NO_CONTENT,
        message: ResponseMessage.NO_CONTENT,
      );

    case DataSource.BAD_REQUEST:
      return ApiErrorModel(
        responseCode: ResponseCode.BAD_REQUEST,
        message: ResponseMessage.BAD_REQUEST,
      );

    case DataSource.UNAUTORISED:
      return ApiErrorModel(
        responseCode: ResponseCode.UNAUTORISED,
        message: ResponseMessage.UNAUTORISED,
      );

    case DataSource.FORBIDDEN:
      return ApiErrorModel(
        responseCode: ResponseCode.FORBIDDEN,
        message: ResponseMessage.FORBIDDEN,
      );

    case DataSource.NOT_FOUND:
      return ApiErrorModel(
        responseCode: ResponseCode.NOT_FOUND,
        message: ResponseMessage.NOT_FOUND,
      );

    case DataSource.INTERNAL_SERVER_ERROR:
      return ApiErrorModel(
        responseCode: ResponseCode.INTERNAL_SERVER_ERROR,
        message: ResponseMessage.INTERNAL_SERVER_ERROR,
      );

    case DataSource.CONNECT_TIMEOUT:
      return ApiErrorModel(
        responseCode: ResponseCode.CONNECT_TIMEOUT,
        message: ResponseMessage.CONNECT_TIMEOUT,
      );

    case DataSource.CANCEL:
      return ApiErrorModel(
        responseCode: ResponseCode.CANCEL,
        message: ResponseMessage.CANCEL,
      );

    case DataSource.RECIEVE_TIMEOUT:
      return ApiErrorModel(
        responseCode: ResponseCode.RECIEVE_TIMEOUT,
        message: ResponseMessage.RECIEVE_TIMEOUT,
      );

    case DataSource.SEND_TIMEOUT:
      return ApiErrorModel(
        responseCode: ResponseCode.SEND_TIMEOUT,
        message: ResponseMessage.SEND_TIMEOUT,
      );

    case DataSource.NO_INTERNET_CONNECTION:
      return ApiErrorModel(
        responseCode: ResponseCode.NO_INTERNET_CONNECTION,
        message: ResponseMessage.NO_INTERNET_CONNECTION,
      );

    case DataSource.CACHE_ERROR:
      return ApiErrorModel(
        responseCode: ResponseCode.CACHE_ERROR,
        message: ResponseMessage.CACHE_ERROR,
      );

    case DataSource.DEFAULT:
      return ApiErrorModel(
        responseCode: ResponseCode.DEFAULT,
        message: ResponseMessage.DEFAULT,
      );
  }
}
