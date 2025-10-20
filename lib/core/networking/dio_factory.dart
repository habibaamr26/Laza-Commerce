import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/cashing_interface.dart';
class DioFactory {
  DioFactory._();
  static final DioFactory singleObject = DioFactory._();

  static Dio oFactory(AuthLocalDataSource localDataSource) {
    return singleObject.getDio(localDataSource);
  }

  Dio? _dio;
  Dio? _dioWithoutInterceptor; //  للـ refresh فقط

  //  للتحكم في الـ refresh المتزامن
  Future<String>? _refreshTokenFuture;

  Dio getDio(AuthLocalDataSource localDataSource) {
    const Duration timeOut = Duration(seconds: 30);

    if (_dio == null) {
      _dio = Dio(BaseOptions(
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
      ));

      // Dio منفصل بدون interceptors للـ refresh
      _dioWithoutInterceptor = Dio(BaseOptions(
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
      ));

      addDioInterceptor(localDataSource);
    }
    return _dio!;
  }

  void addDioInterceptor(AuthLocalDataSource localDataSource) {
    _dio?.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),

      QueuedInterceptorsWrapper( //  بدل InterceptorsWrapper
        onRequest: (options, handler) async {
          final accessToken = await localDataSource.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              //  لو فيه refresh شغال، نستنى نفس الـ future
              final newToken = await _handleTokenRefresh(localDataSource);

              // نعيد الـ request بالتوكن الجديد
              final clonedRequest = await _retryRequest(
                error.requestOptions,
                newToken,
              );
              return handler.resolve(clonedRequest);

            } catch (e) {
              // فشل التجديد → logout
              await localDataSource.clearTokens();
              return handler.reject(error);
            }
          }

          handler.next(error);
        },
      ),
    ]);
  }

  //  يمنع multiple refresh في نفس الوقت
  Future<String> _handleTokenRefresh(AuthLocalDataSource localDataSource) async {
    // لو فيه refresh شغال، نرجع نفس الـ future
    if (_refreshTokenFuture != null) {
      return _refreshTokenFuture!;
    }

    _refreshTokenFuture = _performTokenRefresh(localDataSource);

    try {
      final newToken = await _refreshTokenFuture!;
      return newToken;
    } finally {
      _refreshTokenFuture = null; // ننضف بعد الانتهاء
    }
  }

  Future<String> _performTokenRefresh(AuthLocalDataSource localDataSource) async {
    final refreshToken = await localDataSource.getRefreshToken();

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    //  نستخدم dio منفصل بدون interceptors
    final response = await _dioWithoutInterceptor!.post(
      'https://yourapi.com/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    final newAccessToken = response.data['accessToken'];

    await localDataSource.saveTokens(
      accessToken: newAccessToken,
      refreshToken: refreshToken,
    );

    return newAccessToken;
  }

  Future<Response<dynamic>> _retryRequest(
      RequestOptions requestOptions,
      String newToken,
      ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
    );

    return _dio!.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  //  للتنضيف عند الـ logout
  void reset() {
    _dio?.close();
    _dioWithoutInterceptor?.close();
    _dio = null;
    _dioWithoutInterceptor = null;
    _refreshTokenFuture = null;
  }
}