import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  String? _token;
  final bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void setUser(UserModel user, String token) {
    _currentUser = user;
    _token = token;
    _error = null;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _token = null;
    notifyListeners();
  }

  void setError(String? err) {
    _error = err;
    notifyListeners();
  }
}
