import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({String? authToken}) {
    dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000/api/v1'),
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );
    if (authToken != null) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $authToken';
          handler.next(options);
        },
      ));
    }
  }
}
