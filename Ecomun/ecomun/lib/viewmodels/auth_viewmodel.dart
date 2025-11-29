import 'package:flutter/foundation.dart';
import '../services/mock_repository.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final MockRepository repo;
  
  UserModel? _user;
  bool _loading = false;
  String? _error;

  AuthViewModel(this.repo);

  // Getters
  UserModel? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    final u = await repo.login(email, password);
    _loading = false;

    if (u == null) {
      _error = 'Usuario o contraseña incorrectos';
      notifyListeners();
      return false;
    }

    _user = u;
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}