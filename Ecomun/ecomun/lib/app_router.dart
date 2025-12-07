import 'package:go_router/go_router.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/home_screen.dart';
import 'views/request_form_screen.dart';
import 'views/profile_screen.dart';
import 'views/materials_info_screen.dart';

// Función para crear el router con acceso al AuthViewModel
GoRouter createAppRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authViewModel.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      // Si no está logueado y no está en login o register, redirige a login
      if (!isLoggedIn && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      // Si está logueado y está en login o register, redirige a home
      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return '/home';
      }

      // No redirigir
      return null;
    },
    refreshListenable: authViewModel,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
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