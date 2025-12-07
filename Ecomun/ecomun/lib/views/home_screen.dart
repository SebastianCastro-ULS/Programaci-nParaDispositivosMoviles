import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/materials_viewmodel.dart';
import '../viewmodels/requests_viewmodel.dart';
import '../models/request_model.dart';
import '../widgets/app_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthViewModel>();
      final mv = context.read<MaterialsViewModel>();
      final rv = context.read<RequestsViewModel>();
      
      if (auth.user != null) {
        // Solo carga si no hay datos
        if (mv.materials.isEmpty) {
          mv.loadMaterials();
        }
        if (rv.requests.isEmpty) {
          rv.loadForUser(FirebaseAuth.instance.currentUser!.uid);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final rv = context.watch<RequestsViewModel>();
    final completed = rv.requests.where((r) => r.status == RequestStatus.completed).toList();
    final totalQty = rv.requests.fold<double>(0, (p, c) => p + c.quantity);

    return Scaffold(
      appBar: AppBar(title: const Text('Ecomun')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido, ${auth.user?.name ?? 'Usuario'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total reciclado', style: TextStyle(fontSize: 12)),
                        Text(
                          '${totalQty.toStringAsFixed(1)} kg',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Solicitudes completadas', style: TextStyle(fontSize: 12)),
                        Text(
                          '${completed.length}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Mis solicitudes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: rv.loading
                  ? const Center(child: CircularProgressIndicator())
                  : rv.requests.isEmpty
                      ? const Center(
                          child: Text(
                            'No tienes solicitudes aún.\n¡Crea tu primera solicitud!',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: rv.requests.length,
                          itemBuilder: (context, i) {
                            final r = rv.requests[i];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.recycling),
                                title: Text('Cantidad: ${r.quantity} kg'),
                                subtitle: Text(
                                  '${r.date.toLocal().toString().split(' ')[0]}${r.observations != null && r.observations!.isNotEmpty ? '\n${r.observations}' : ''}',
                                ),
                                trailing: Chip(
                                  label: Text(
                                    _getStatusText(r.status),
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  backgroundColor: _getStatusColor(r.status),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/request');
                },
                icon: const Icon(Icons.add),
                label: const Text('Solicitar recojo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return 'Pendiente';
      case RequestStatus.approved:
        return 'Aprobado';
      case RequestStatus.completed:
        return 'Completado';
      case RequestStatus.rejected:
        return 'Rechazado';
    }
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return Colors.orange.shade100;
      case RequestStatus.approved:
        return Colors.blue.shade100;
      case RequestStatus.completed:
        return Colors.green.shade100;
      case RequestStatus.rejected:
        return Colors.red.shade100;
    }
  }
}
