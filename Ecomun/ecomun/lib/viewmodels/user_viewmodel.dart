import 'package:flutter/foundation.dart';
import '../services/firebase_user_service.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final FirebaseUserService _userService;
  
  UserModel? _user;
  bool _loading = false;
  String? _error;

  UserViewModel(this._userService);

  // Getters
  UserModel? get user => _user;
  bool get loading => _loading;
  String? get error => _error;

  // Cargar información del usuario
  Future<void> loadUser(String id) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _userService.getUser(id);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar usuario: ${e.toString()}';
      notifyListeners();
    }
  }

  // Actualizar usuario
  Future<bool> updateUser(UserModel user) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.updateUser(user);
      _user = user;
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al actualizar usuario: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}