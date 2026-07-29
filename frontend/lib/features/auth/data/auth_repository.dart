import '../../../core/network/api_client.dart';
import '../../../models/user_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<Map<String, dynamic>> login(
      String role, String identifier, String password) async {
    final response = await apiClient.dio.post(
      '/auth/login',
      data: {'role': role, 'identifier': identifier, 'password': password},
    );
    return response.data;
  }

  Future<UserModel> fetchCurrentUser() async {
    final response = await apiClient.dio.get('/auth/me');
    return UserModel.fromJson(response.data);
  }
}
