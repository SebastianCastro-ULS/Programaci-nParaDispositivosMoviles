import 'package:flutter/foundation.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_user_service.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final FirebaseUserService _userService;
  
  UserModel? _user;
  bool _loading = false;
  String? _error;

  AuthViewModel(this._authService, this._userService) {
    // Escuchar cambios en el estado de autenticación
    _authService.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser != null) {
        // Cargar datos del usuario desde Firestore
        _user = await _userService.getUser(firebaseUser.uid);
        notifyListeners();
      } else {
        _user = null;
        notifyListeners();
      }
    });
  }

  // Getters
  UserModel? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  //Iniciar sesión
  Future<bool> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final userModel = await _authService.signInWithEmailPassword(email, password);
      
      if (userModel != null) {
        // Obtener datos completos desde firestore
        _user = await _userService.getUser(userModel.id);
        /* Si no existe en Firestore, crear el registro */
        if (_user == null) {
          await _userService.createUser(userModel);
          _user = userModel;
        }   
        notifyListeners();
        return true;
      }
      
      _loading = false;
      _error = 'Error al iniciar sesión';
      notifyListeners();
      return false;
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Registrar nuevo usuario
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    String? location,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      // Crear usuario en firebase
      final userModel = await _authService.registerWithEmailPassword(
        email: email,
        password: password,
        name: name,
        location: location,
      );

      if (userModel != null) {
        // Guardar información adicional en Firestore
        await _userService.createUser(userModel);
        _user = userModel;
        _loading = false;
        notifyListeners();
        return true;
      }

      _loading = false;
      _error = 'Error al registrar usuario';
      notifyListeners();
      return false;
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  //Cerrar sesion
  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // Actualizar perfil 
  Future<bool> updateProfile(UserModel updatedUser) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      // Actualizar en Firestore
      await _userService.updateUser(updatedUser);
      
      // Actualizar nombre en Firebase
      await _authService.updateProfile(displayName: updatedUser.name);
      
      _user = updatedUser;
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al actualizar perfil: $e';
      notifyListeners();
      return false;
    }
  }

  //Resetear contraseña
  Future<bool> resetPassword(String email) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  //Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}