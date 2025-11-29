import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/requests_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos los ViewModels necesarios
    final auth = context.watch<AuthViewModel>();
    final rv = context.watch<RequestsViewModel>();
    // Aqui calculamos estadísticas del usuario
    // Contamos solicitudes con estado 'completed'
    
    final completed = rv.requests.where((r) => r.status.name == 'completed').length;
    final total = rv.requests.fold<double>(0, (p, c) => p + c.quantity);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 34,
              child: Text(
                auth.user?.name.split(' ').map((s) => s[0]).take(2).join() ?? 'U',
              ),
            ),
            const SizedBox(height: 8),
            //NOmbre
            Text(
              auth.user?.name ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            //Ubiación
            Text(auth.user?.location ?? ''),
            const SizedBox(height: 12),
            //Estadísticas del usuario
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total reciclado'),
                        Text('${total.toStringAsFixed(1)} kg'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Solicitudes completadas'),
                        Text('$completed'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}