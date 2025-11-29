import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/materials_viewmodel.dart';
import '../widgets/material_tile.dart';

class MaterialsInfoScreen extends StatelessWidget {
  const MaterialsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ViewModel de materiales
    final mv = context.watch<MaterialsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Materiales reciclables')),
      body: mv.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: mv.materials.length,
              itemBuilder: (context, i) => MaterialTile(material: mv.materials[i]),
            ),
    );
  }
}