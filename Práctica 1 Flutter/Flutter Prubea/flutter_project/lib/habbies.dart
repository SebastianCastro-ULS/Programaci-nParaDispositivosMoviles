import 'package:flutter/material.dart';

class PantallaHobbies extends StatelessWidget {
  const PantallaHobbies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis hobbies'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Durante mi tiempo libre me gusta hacer lo siguiente: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Icon(Icons.book, color: Colors.orange),
                SizedBox(width: 10),
                Text('Leer libros (ahora estoy leyendo Noches Blancas)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.videogame_asset, color: Colors.orange),
                SizedBox(width: 10),
                Text('Jugar videojuegos (especialmente FIFA)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.music_note, color: Colors.orange),
                SizedBox(width: 10),
                Text('Escuchar música (del grupo 3AM)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.music_note, color: Colors.orange),
                SizedBox(width: 10),
                Text('Hacer deportes (principalmente futbol y voley)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
