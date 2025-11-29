import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'services/mock_repository.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/materials_viewmodel.dart';
import 'viewmodels/requests_viewmodel.dart';

/* 
 * Punto de entrada principal de la aplicación.
 */

void main() async {
  // Asegura que los bindings de Flutter esten inicializados antes de continuar
  WidgetsFlutterBinding.ensureInitialized();
  
  // Creamos una instancia del repositorio que manejará todos los datos
  final repo = MockRepository();
  
  //Inicializamos la aplicación
  runApp(
    MultiProvider(
      providers: [
        //Compartimos una instancia ya creada del repositorio.
        Provider<MockRepository>.value(value: repo),
        ChangeNotifierProvider(create: (_) => AuthViewModel(repo)),
        ChangeNotifierProvider(create: (_) => UserViewModel(repo)),
        ChangeNotifierProvider(create: (_) => MaterialsViewModel(repo)),
        ChangeNotifierProvider(create: (_) => RequestsViewModel(repo)),
      ],
      child: const EcomunApp(),
    ),
  );
}

class EcomunApp extends StatelessWidget {
  const EcomunApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    
    // MaterialApp.router permite usar GoRouter para navegación avanzada.
    return MaterialApp.router(
      title: 'Ecomun',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      routerConfig: createAppRouter(authViewModel), // ✅ Pasa el authViewModel
    );
  }
}