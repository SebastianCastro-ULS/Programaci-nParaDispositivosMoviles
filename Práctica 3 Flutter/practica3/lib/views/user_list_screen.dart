import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../models/user.dart';
import 'user_form_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();

    final email = ModalRoute.of(context)?.settings.arguments ?? 'Usuario';

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido: $email')),

      body: Column(
        children: [
          SwitchListTile(
            title: const Text("Mostrar solo activos"),
            value: viewModel.mostrarSoloActivos,
            onChanged: viewModel.cambiarFiltro,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.usuariosFiltrados.length,
              itemBuilder: (context, index) {
                final user = viewModel.usuariosFiltrados[index];

                return Card(
                  child: ListTile(
                    title: Text("${user.nombre} (Edad: ${user.edad})"),
                    subtitle: Text(
                        "${user.genero} | ${user.correo} | ${user.activo ? 'Activo' : 'Inactivo'}"),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final actualizado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserFormScreen(
                                  usuario: user,
                                  indice: index,
                                ),
                              ),
                            );

                            if (actualizado != null && actualizado is User) {
                              viewModel.editarUsuario(index, actualizado);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => viewModel.eliminarUsuario(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UserFormScreen(),
            ),
          );

          if (nuevo != null && nuevo is User) {
            viewModel.agregarUsuario(nuevo);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
