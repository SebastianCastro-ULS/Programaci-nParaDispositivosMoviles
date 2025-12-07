import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/material_model.dart';

// Servicio para gestionar materiales reciclables
class FirebaseMaterialsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'materials';

  // Obtener todos los materiales
  Future<List<MaterialModel>> getMaterials() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .orderBy('name')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MaterialModel(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          icon: data['icon'] ?? 'recycling',
          tips: data['tips'] ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener materiales: $e');
    }
  }

  // Obtener material por ID
  Future<MaterialModel?> getMaterial(String materialId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(materialId).get();
      
      if (!doc.exists) return null;

      final data = doc.data()!;
      return MaterialModel(
        id: doc.id,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        icon: data['icon'] ?? 'recycling',
        tips: data['tips'] ?? '',
      );
    } catch (e) {
      throw Exception('Error al obtener material: $e');
    }
  }

  // Crear nuevo material -- adm
  Future<String> createMaterial(MaterialModel material) async {
    try {
      final docRef = await _firestore.collection(_collection).add({
        'name': material.name,
        'description': material.description,
        'icon': material.icon,
        'tips': material.tips,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear material: $e');
    }
  }

  // Actualizar material -- adm
  Future<void> updateMaterial(MaterialModel material) async {
    try {
      await _firestore.collection(_collection).doc(material.id).update({
        'name': material.name,
        'description': material.description,
        'icon': material.icon,
        'tips': material.tips,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al actualizar material: $e');
    }
  }

  // Eliminar material -- adm
  Future<void> deleteMaterial(String materialId) async {
    try {
      await _firestore.collection(_collection).doc(materialId).delete();
    } catch (e) {
      throw Exception('Error al eliminar material: $e');
    }
  }

  // Stream de materiales
  Stream<List<MaterialModel>> materialsStream() {
    return _firestore
        .collection(_collection)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return MaterialModel(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          icon: data['icon'] ?? 'recycling',
          tips: data['tips'] ?? '',
        );
      }).toList();
    });
  }

  // Inicializar materiales por defecto
  Future<void> initializeDefaultMaterials() async {
    try {
      final snapshot = await _firestore.collection(_collection).limit(1).get();
      
      // Solo inicializar si no hay materiales
      if (snapshot.docs.isEmpty) {
        final defaultMaterials = [
          {
            'name': 'Plástico',
            'description': 'Botellas, envases plásticos',
            'icon': 'local_drink',
            'tips': 'Lava y aplasta antes de reciclar',
          },
          {
            'name': 'Papel y cartón',
            'description': 'Periódicos, cajas',
            'icon': 'description',
            'tips': 'Mantén seco y sin restos de comida',
          },
          {
            'name': 'Vidrio',
            'description': 'Botellas, frascos',
            'icon': 'glass',
            'tips': 'Retira tapas y enjuaga',
          },
          {
            'name': 'Metales',
            'description': 'Latas y chatarra',
            'icon': 'construction',
            'tips': 'Aplasta latas para ahorrar espacio',
          },
        ];

        for (var material in defaultMaterials) {
          await _firestore.collection(_collection).add({
            ...material,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      throw Exception('Error al inicializar materiales: $e');
    }
  }
}