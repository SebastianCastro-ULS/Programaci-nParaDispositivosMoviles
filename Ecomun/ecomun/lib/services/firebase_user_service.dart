import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

//Servicio para gestionar usuarios en Firestore
class FirebaseUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  // Crear o actualizar usuario en Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'location': user.location,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al crear usuario: $e');
    }
  }

  // Obtener usuario por ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      
      if (!doc.exists) return null;

      final data = doc.data()!;
      return UserModel(
        id: doc.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        location: data['location'],
      );
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  // Actualizar información del usuario
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).update({
        'name': user.name,
        'email': user.email,
        'location': user.location,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  // Eliminar usuario
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      throw Exception('Error al eliminar usuario: $e');
    }
  }

  // Stream del usuario
  Stream<UserModel?> userStream(String userId) {
    return _firestore
        .collection(_collection)
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;

      final data = doc.data()!;
      return UserModel(
        id: doc.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        location: data['location'],
      );
    });
  }
}