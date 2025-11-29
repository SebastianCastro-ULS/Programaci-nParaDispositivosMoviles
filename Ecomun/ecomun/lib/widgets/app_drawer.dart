import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; 
import '../viewmodels/auth_viewmodel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Obtenemos el estado de autenticación para mostrar la info del usuario
    final auth = context.watch<AuthViewModel>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            //Información del usuario.
            accountName: Text(auth.user?.name ?? ''),
            accountEmail: Text(auth.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: Text(auth.user?.name.substring(0, 1) ?? 'U'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              context.go('/home'); 
            },
          ),
          //Opcioin para los materiales.
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Materiales'),
            onTap: () {
              context.push('/materials'); 
            },
          ),
          //Opción para el perfil
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              context.push('/profile'); 
            },
          ),
          const Divider(),
          //Para cerrar la sesión.
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              context.read<AuthViewModel>().logout();
              context.go('/login'); 
            },
          ),
        ],
      ),
    );
  }
}