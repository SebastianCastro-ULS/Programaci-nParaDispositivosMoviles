/*import 'package:flutter/material.dart';*/
import 'package:go_router/go_router.dart';
/*import 'package:provider/provider.dart';*/
import 'viewmodels/auth_viewmodel.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/request_form_screen.dart';
import 'views/profile_screen.dart';
import 'views/materials_info_screen.dart';

// ✅ Función para crear el router con acceso al AuthViewModel
GoRouter createAppRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: '/login', // ✅ Inicia en login
    redirect: (context, state) {
      final isLoggedIn = authViewModel.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/login';

      // Si no está logueado y no está en login, redirige a login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // Si está logueado y está en login, redirige a home
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }

      // No redirigir
      return null;
    },
    refreshListenable: authViewModel, // ✅ Escucha cambios en auth
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/request',
        builder: (context, state) => const RequestFormScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/materials',
        builder: (context, state) => const MaterialsInfoScreen(),
      ),
    ],
  );
}