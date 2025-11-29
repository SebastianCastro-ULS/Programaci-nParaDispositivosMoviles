import 'dart:math';
import '../models/user_model.dart';
import '../models/material_model.dart';
import '../models/request_model.dart';

class MockRepository {
  final Map<String, UserModel> _users = {};
  final Map<String, MaterialModel> _materials = {};
  final Map<String, RequestModel> _requests = {};

  MockRepository() {
    _initializeSeedData();
  }

  void _initializeSeedData() {
    // Seed user data
    final user = UserModel(
      id: 'u1',
      name: 'Sebastian Castro',
      email: 'scastrom@ulasalle.edu.pe',
      location: 'Lima, Perú',
    );
    _users[user.id] = user;

    // Seed materials data
    final mats = [
      MaterialModel(
        id: 'm1',
        name: 'Plástico',
        description: 'Botellas, envases plásticos',
        icon: 'local_drink',
        tips: 'Lava y aplasta antes de reciclar',
      ),
      MaterialModel(
        id: 'm2',
        name: 'Papel y cartón',
        description: 'Periódicos, cajas',
        icon: 'description',
        tips: 'Mantén seco y sin restos de comida',
      ),
      MaterialModel(
        id: 'm3',
        name: 'Vidrio',
        description: 'Botellas, frascos',
        icon: 'glass',
        tips: 'Retira tapas y enjuaga',
      ),
      MaterialModel(
        id: 'm4',
        name: 'Metales',
        description: 'Latas y chatarra',
        icon: 'construction',
        tips: 'Aplasta latas para ahorrar espacio',
      ),
    ];

    for (var m in mats) {
      _materials[m.id] = m;
    }

    // Seed example requests
    final r1 = RequestModel(
      id: 'r1',
      userId: user.id,
      materialId: 'm1',
      quantity: 3.5,
      date: DateTime.now().subtract(const Duration(days: 10)),
      observations: 'Bolsas',
      status: RequestStatus.completed,
    );

    final r2 = RequestModel(
      id: 'r2',
      userId: user.id,
      materialId: 'm2',
      quantity: 1.2,
      date: DateTime.now().subtract(const Duration(days: 3)),
      observations: 'Cajas',
      status: RequestStatus.completed,
    );

    _requests[r1.id] = r1;
    _requests[r2.id] = r2;
  }

  // Auth
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final u = _users.values.firstWhere((u) => u.email == email);
      return u;
    } catch (e) {
      return null;
    }
  }

  // Users
  Future<UserModel?> getUser(String id) async {
    return _users[id];
  }

  // Materials
  Future<List<MaterialModel>> getMaterials() async {
    return _materials.values.toList();
  }

  // Requests
  Future<List<RequestModel>> getRequestsForUser(String userId) async {
    return _requests.values.where((r) => r.userId == userId).toList();
  }

  Future<RequestModel> createRequest(RequestModel r) async {
    final id = 'r${_requests.length + 1}${Random().nextInt(999)}';
    final nr = RequestModel(
      id: id,
      userId: r.userId,
      materialId: r.materialId,
      quantity: r.quantity,
      date: r.date,
      observations: r.observations,
    );
    _requests[id] = nr;
    return nr;
  }

  Future<void> updateRequest(RequestModel r) async {
    _requests[r.id] = r;
  }
}