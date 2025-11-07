import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Widget principal que lanza la app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomNavigationBar Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

// Página principal con navegación inferior
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _nombreUsuario = 'Invitado';

  // Lista de pantallas que se muestran según el tab seleccionado
  List<Widget> get _pages => [
        const Center(child: Text('Inicio', style: TextStyle(fontSize: 24))),
        const Center(child: Text('Usuarios', style: TextStyle(fontSize: 24))),
        const Center(child: Text('Configuración', style: TextStyle(fontSize: 24))),
        _perfilTab(), // Tab de perfil con nombre y botón
      ];

  // Cambia el tab seleccionado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Vista del tab Perfil
  Widget _perfilTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nombre: $_nombreUsuario', style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Navega a la pantalla de edición y espera el resultado
              final nombre = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditarPerfilScreen()),
              );
              // Si se recibe un nombre válido, actualiza el estado
              if (nombre != null && nombre.toString().trim().isNotEmpty) {
                setState(() {
                  _nombreUsuario = nombre;
                });
              }
            },
            child: const Text('Editar perfil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo BottomNavigationBar')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // permite más de 3 tabs
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Usuarios'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Pantalla para editar el nombre del perfil
class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Regresa el nombre ingresado a la pantalla anterior
                Navigator.pop(context, _controller.text.trim());
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
