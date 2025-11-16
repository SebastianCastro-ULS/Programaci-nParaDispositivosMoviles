import 'package:flutter/material.dart';
import '../models/user.dart';

// En teoría se dministra la lista de usuarios y se notifica cambios

class UserViewModel extends ChangeNotifier {
  final List<User> _usuarios = [];

  List<User> get usuarios => _usuarios;

  bool mostrarSoloActivos = false; // Filtro

  // Retorna lista filtrada de usuarios con estado activo
  List<User> get usuariosFiltrados {
    if (mostrarSoloActivos) {
      return _usuarios.where((u) => u.activo).toList();
    }
    return _usuarios;
  }

  void agregarUsuario(User usuario) {
    _usuarios.add(usuario);
    notifyListeners(); // Actualiza
  }

  void editarUsuario(int index, User usuarioNuevo) {
    _usuarios[index] = usuarioNuevo;
    notifyListeners();
  }

  void eliminarUsuario(int index) {
    _usuarios.removeAt(index);
    notifyListeners();
  }

  // Cambia el valor del filtro
  void cambiarFiltro(bool value) {
    mostrarSoloActivos = value;
    notifyListeners();
  }
}
