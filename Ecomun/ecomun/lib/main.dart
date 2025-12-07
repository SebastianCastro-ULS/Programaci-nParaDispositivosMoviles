import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app_router.dart';
import 'services/firebase_auth_service.dart';
import 'services/firebase_user_service.dart';
import 'services/firebase_materials_service.dart';
import 'services/firebase_requests_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/materials_viewmodel.dart';
import 'viewmodels/requests_viewmodel.dart';

void main() async {
  // Asegura que los bindings de Flutter estén inicializados antes de continuar
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Crear instancias de los servicios Firebase
  final authService = FirebaseAuthService();
  final userService = FirebaseUserService();
  final materialsService = FirebaseMaterialsService();
  final requestsService = FirebaseRequestsService();
  
  // Inicializar materiales por defecto si es necesario
  // Esto solo se ejecuta una vez si no hay materiales en la base de datos
  try {
    await materialsService.initializeDefaultMaterials();
  } catch (e) {
    debugPrint('Error al inicializar materiales: $e');
  }
  
  // Inicializamos la aplicación
  runApp(
    MultiProvider(
      providers: [
        // Servicios
        Provider<FirebaseAuthService>.value(value: authService),
        Provider<FirebaseUserService>.value(value: userService),
        Provider<FirebaseMaterialsService>.value(value: materialsService),
        Provider<FirebaseRequestsService>.value(value: requestsService),
        
        // ViewModels (ChangeNotifierProvider para estado reactivo)
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(authService, userService),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(userService),
        ),
        ChangeNotifierProvider(
          create: (_) => MaterialsViewModel(materialsService),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestsViewModel(requestsService),
        ),
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
        // Configuración adicional del tema
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),
      ),
      routerConfig: createAppRouter(authViewModel),
      debugShowCheckedModeBanner: false,
    );
  }
}