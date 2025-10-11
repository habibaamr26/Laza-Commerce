import 'api_error_handler.dart';
import 'api_error_model.dart';

class ApiResult<T> {
  ApiResult._();
  factory ApiResult.success(T data) = ApiSuccess<T>;
  factory ApiResult.error(Object e) = ApiError<T>;
  when({
    required Function(T data) onSuccess,
    required Function(ApiErrorModel error) onError,
  }) {
    if (this is ApiSuccess<T>) {
      return onSuccess((this as ApiSuccess<T>).data);
    } else {
      final apiError = this as ApiError<T>;
      final handler = ErrorHandler.handle(apiError.error);
      return onError(handler.apiErrorModel);
    }
  }
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  ApiSuccess(this.data) : super._();
}

class ApiError<T> extends ApiResult<T> {
  final Object error;

  ApiError(this.error) : super._();
}
