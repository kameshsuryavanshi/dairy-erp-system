import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? authToken;

  AuthInterceptor({this.authToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authToken != null && authToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle session expiration
    }
    super.onError(err, handler);
  }
}
