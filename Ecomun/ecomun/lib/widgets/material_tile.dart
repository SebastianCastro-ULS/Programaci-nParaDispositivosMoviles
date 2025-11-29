import 'package:flutter/material.dart';
import '../models/material_model.dart';

class MaterialTile extends StatelessWidget {
  final MaterialModel material;

  const MaterialTile({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //Icono del material
        leading: Icon(_iconFor(material.icon)),
        title: Text(material.name),
        // Información detallada
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(material.description),
            const SizedBox(height: 4),
            Text(
              'Consejo: ${material.tips}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

//Iconos
  IconData _iconFor(String v) {
    switch (v) {
      case 'local_drink':
        return Icons.local_drink;
      case 'description':
        return Icons.description;
      case 'glass':
        return Icons.wine_bar;
      default:
        return Icons.recycling;
    }
  }
}