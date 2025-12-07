import 'package:flutter/foundation.dart';
import '../services/firebase_materials_service.dart';
import '../models/material_model.dart';

class MaterialsViewModel extends ChangeNotifier {
  final FirebaseMaterialsService _materialsService;
  
  List<MaterialModel> _materials = [];
  bool _loading = false;
  String? _error;

  MaterialsViewModel(this._materialsService);

  // Getters
  List<MaterialModel> get materials => _materials;
  bool get loading => _loading;
  String? get error => _error;

  //Cargar materiales desde Firebase
  Future<void> loadMaterials() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _materials = await _materialsService.getMaterials();
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar materiales: ${e.toString()}';
      notifyListeners();
    }
  }

  //Obtener material por ID
  MaterialModel? getMaterialById(String id) {
    try {
      return _materials.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  //Crear nuevo material -- adm
  Future<bool> createMaterial(MaterialModel material) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final id = await _materialsService.createMaterial(material);
      final newMaterial = MaterialModel(
        id: id,
        name: material.name,
        description: material.description,
        icon: material.icon,
        tips: material.tips,
      );
      _materials.add(newMaterial);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al crear material: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  //Actualizar material -- adm
  Future<bool> updateMaterial(MaterialModel material) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _materialsService.updateMaterial(material);
      final index = _materials.indexWhere((m) => m.id == material.id);
      if (index != -1) {
        _materials[index] = material;
      }
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al actualizar material: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  //Eliminar material -- adm
  Future<bool> deleteMaterial(String materialId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _materialsService.deleteMaterial(materialId);
      _materials.removeWhere((m) => m.id == materialId);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al eliminar material: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  //Inicializar materiales por defecto
  Future<void> initializeDefaultMaterials() async {
    try {
      await _materialsService.initializeDefaultMaterials();
      await loadMaterials();
    } catch (e) {
      _error = 'Error al inicializar materiales: ${e.toString()}';
      notifyListeners();
    }
  }

  //Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}