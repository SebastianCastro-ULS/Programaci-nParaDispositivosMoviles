import 'package:flutter/foundation.dart';
import '../services/mock_repository.dart';
import '../models/material_model.dart';

class MaterialsViewModel extends ChangeNotifier {
  final MockRepository repo;
  
  List<MaterialModel> _materials = [];
  bool _loading = false;
  String? _error;

  MaterialsViewModel(this.repo);

  // Getters
  List<MaterialModel> get materials => _materials;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadMaterials() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _materials = await repo.getMaterials();
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar materiales: ${e.toString()}';
      notifyListeners();
    }
  }

  MaterialModel? getMaterialById(String id) {
    try {
      return _materials.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}