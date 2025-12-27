import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/cycle_tracking/presentation/screens/home_screen.dart';
import '../../features/cycle_tracking/presentation/screens/symptoms_screen.dart';
import '../../features/fasting/presentation/screens/fasting_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

/// Configuración de rutas de la aplicación usando go_router
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/symptoms',
        name: 'symptoms',
        builder: (context, state) => const SymptomsScreen(),
      ),
      GoRoute(
        path: '/fasting',
        name: 'fasting',
        builder: (context, state) => const FastingScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}

