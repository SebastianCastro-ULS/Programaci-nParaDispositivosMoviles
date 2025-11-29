import 'package:flutter/foundation.dart';
import '../services/mock_repository.dart';
import '../models/request_model.dart';

class RequestsViewModel extends ChangeNotifier {
  final MockRepository repo;
  
  List<RequestModel> _requests = [];
  bool _loading = false;
  String? _error;

  RequestsViewModel(this.repo);

  // Getters
  List<RequestModel> get requests => _requests;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadForUser(String userId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _requests = await repo.getRequestsForUser(userId);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Error al cargar solicitudes: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<bool> create(RequestModel r) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final nr = await repo.createRequest(r);
      _requests.insert(0, nr); // Agregar al inicio para mostrar las más recientes primero
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

  List<RequestModel> getRequestsByStatus(RequestStatus status) {
    return _requests.where((r) => r.status == status).toList();
  }

  int getCompletedRequestsCount() {
    return _requests.where((r) => r.status == RequestStatus.completed).length;
  }

  double getTotalRecycledQuantity() {
    return _requests
        .where((r) => r.status == RequestStatus.completed)
        .fold(0.0, (sum, r) => sum + r.quantity);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}