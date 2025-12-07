import 'package:flutter/foundation.dart';
import '../services/firebase_requests_service.dart';
import '../models/request_model.dart';

class RequestsViewModel extends ChangeNotifier {
  final FirebaseRequestsService _requestsService;
  
  List<RequestModel> _requests = [];
  bool _loading = false;
  String? _error;

  RequestsViewModel(this._requestsService);

  // Getters
  List<RequestModel> get requests => _requests;
  bool get loading => _loading;
  String? get error => _error;

  // Cargar solicitudes del usuario
  Future<void> loadForUser(String userId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _requests = await _requestsService.getRequestsForUser(userId);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar solicitudes: ${e.toString()}';
      notifyListeners();
    }
  }

  // Crear nueva solicitud
  Future<bool> create(RequestModel r) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final newRequest = await _requestsService.createRequest(r);
      _requests.insert(0, newRequest);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al crear solicitud: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Actualizar estado de solicitud
  Future<bool> updateStatus(String requestId, RequestStatus status) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _requestsService.updateRequestStatus(requestId, status);
      
      final index = _requests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        _requests[index] = _requests[index].copyWith(status: status);
      }
      
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al actualizar solicitud: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Eliminar solicitud
  Future<bool> delete(String requestId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _requestsService.deleteRequest(requestId);
      _requests.removeWhere((r) => r.id == requestId);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      _error = 'Error al eliminar solicitud: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Obtener solicitudes por estado
  List<RequestModel> getRequestsByStatus(RequestStatus status) {
    return _requests.where((r) => r.status == status).toList();
  }

  // Obtener cantidad de solicitudes completadas
  int getCompletedRequestsCount() {
    return _requests.where((r) => r.status == RequestStatus.completed).length;
  }

  // Obtener total de cantidad reciclada
  double getTotalRecycledQuantity() {
    return _requests
        .where((r) => r.status == RequestStatus.completed)
        .fold(0.0, (sum, r) => sum + r.quantity);
  }

  // Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}