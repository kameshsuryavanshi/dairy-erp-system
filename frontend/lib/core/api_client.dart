import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({String? baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000/api/v1'),
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
          headers: {'Content-Type': 'application/json'},
        ));
  final Dio _dio;
  String? _token;

  void setToken(String? value) { _token = value; }
  Options get _options => Options(headers: _token == null ? {} : {'Authorization': 'Bearer $_token'});
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async => Map<String, dynamic>.from((await _dio.post('/auth/login', data: data)).data);
  Future<Map<String, dynamic>> dashboard() async => Map<String, dynamic>.from((await _dio.get('/dashboard', options: _options)).data);
  Future<List<dynamic>> getList(String path) async => List<dynamic>.from((await _dio.get(path, options: _options)).data);
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async => Map<String, dynamic>.from((await _dio.post(path, data: data, options: _options)).data);
}
