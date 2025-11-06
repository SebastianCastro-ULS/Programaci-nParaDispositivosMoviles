import 'package:flutter/material.dart';

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: const Color.fromARGB(255, 121, 29, 103),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/147/147144.png',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sebastian Castro',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estudiante de Ingenieria de Software y Marketing; me encanta el fútbol',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.email, color: Color.fromARGB(255, 39, 41, 157)),
                SizedBox(width: 8),
                Text('scastrom@ulasalle.edu.pe'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.phone, color: Color.fromARGB(255, 39, 41, 157)),
                SizedBox(width: 8),
                Text('+51 987 654 321'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
