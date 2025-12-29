import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/personal_info_screen.dart';
import '../../features/onboarding/presentation/screens/last_period_screen.dart';
import '../../features/onboarding/presentation/screens/cycle_regularity_screen.dart';
import '../../features/onboarding/presentation/screens/fasting_experience_screen.dart';
import '../../features/onboarding/presentation/screens/goals_screen.dart';
import '../../features/onboarding/presentation/screens/companionship_style_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_complete_screen.dart';
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
      // Onboarding flow
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/personal-info',
        name: 'personal-info',
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: '/onboarding/last-period',
        name: 'last-period',
        builder: (context, state) => const LastPeriodScreen(),
      ),
      GoRoute(
        path: '/onboarding/cycle-regularity',
        name: 'cycle-regularity',
        builder: (context, state) => const CycleRegularityScreen(),
      ),
      GoRoute(
        path: '/onboarding/fasting-experience',
        name: 'fasting-experience',
        builder: (context, state) => const FastingExperienceScreen(),
      ),
      GoRoute(
        path: '/onboarding/goals',
        name: 'goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/onboarding/companionship-style',
        name: 'companionship-style',
        builder: (context, state) => const CompanionshipStyleScreen(),
      ),
      GoRoute(
        path: '/onboarding/complete',
        name: 'onboarding-complete',
        builder: (context, state) => const OnboardingCompleteScreen(),
      ),
      // Main app screens
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
