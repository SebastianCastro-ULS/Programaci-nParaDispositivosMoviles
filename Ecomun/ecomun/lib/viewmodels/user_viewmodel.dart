import 'package:flutter/foundation.dart';
import '../services/mock_repository.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final MockRepository repo;
  
  UserModel? _user;
  bool _loading = false;
  String? _error;

  UserViewModel(this.repo);

  // Getters públicos
  UserModel? get user => _user;
  bool get loading => _loading;
  String? get error => _error;

  //Cargamos la información del usuario !!! (P)
  Future<void> loadUser(String id) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await repo.getUser(id);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar usuario: ${e.toString()}';
      notifyListeners();
    }
  }

  //Limpiamos el mensaje de error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}