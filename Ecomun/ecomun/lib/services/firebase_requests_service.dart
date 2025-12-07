import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/request_model.dart';

// Servicio para gestionar solicitudes de recojo
class FirebaseRequestsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'requests';

  // Crear nueva solicitud
  Future<RequestModel> createRequest(RequestModel request) async {
    try {
      final docRef = await _firestore.collection(_collection).add({
        'userId': request.userId,
        'materialId': request.materialId,
        'quantity': request.quantity,
        'date': Timestamp.fromDate(request.date),
        'observations': request.observations,
        'status': request.status.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return RequestModel(
        id: docRef.id,
        userId: request.userId,
        materialId: request.materialId,
        quantity: request.quantity,
        date: request.date,
        observations: request.observations,
        status: request.status,
      );
    } catch (e) {
      throw Exception('Error al crear solicitud: $e');
    }
  }

  // Obtener solicitudes de un usuario
  Future<List<RequestModel>> getRequestsForUser(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return RequestModel(
          id: doc.id,
          userId: data['userId'] ?? '',
          materialId: data['materialId'] ?? '',
          quantity: (data['quantity'] ?? 0).toDouble(),
          date: (data['date'] as Timestamp).toDate(),
          observations: data['observations'],
          status: _parseStatus(data['status']),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener solicitudes: $e');
    }
  }

  // Obtener solicitud por ID
  Future<RequestModel?> getRequest(String requestId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(requestId).get();
      
      if (!doc.exists) return null;

      final data = doc.data()!;
      return RequestModel(
        id: doc.id,
        userId: data['userId'] ?? '',
        materialId: data['materialId'] ?? '',
        quantity: (data['quantity'] ?? 0).toDouble(),
        date: (data['date'] as Timestamp).toDate(),
        observations: data['observations'],
        status: _parseStatus(data['status']),
      );
    } catch (e) {
      throw Exception('Error al obtener solicitud: $e');
    }
  }

  // Actualizar estado de solicitud
  Future<void> updateRequestStatus(String requestId, RequestStatus status) async {
    try {
      await _firestore.collection(_collection).doc(requestId).update({
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al actualizar solicitud: $e');
    }
  }

  // Actualizar solicitud completa
  Future<void> updateRequest(RequestModel request) async {
    try {
      await _firestore.collection(_collection).doc(request.id).update({
        'materialId': request.materialId,
        'quantity': request.quantity,
        'date': Timestamp.fromDate(request.date),
        'observations': request.observations,
        'status': request.status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al actualizar solicitud: $e');
    }
  }

  // Eliminar solicitud
  Future<void> deleteRequest(String requestId) async {
    try {
      await _firestore.collection(_collection).doc(requestId).delete();
    } catch (e) {
      throw Exception('Error al eliminar solicitud: $e');
    }
  }

  // Stream de solicitudes del usuario (tiempo real)
  Stream<List<RequestModel>> requestsStreamForUser(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return RequestModel(
          id: doc.id,
          userId: data['userId'] ?? '',
          materialId: data['materialId'] ?? '',
          quantity: (data['quantity'] ?? 0).toDouble(),
          date: (data['date'] as Timestamp).toDate(),
          observations: data['observations'],
          status: _parseStatus(data['status']),
        );
      }).toList();
    });
  }

  // Parsear estado
  RequestStatus _parseStatus(String? status) {
    switch (status) {
      case 'approved':
        return RequestStatus.approved;
      case 'completed':
        return RequestStatus.completed;
      case 'rejected':
        return RequestStatus.rejected;
      default:
        return RequestStatus.pending;
    }
  }
}