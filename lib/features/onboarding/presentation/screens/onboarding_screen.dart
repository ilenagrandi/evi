import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/evi_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla de onboarding con 3 pasos que explican EVI
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Bienvenida a EVI',
      description:
          'Una app delicada y empática que te acompaña en cada fase de tu ciclo menstrual, ayudándote a entender y cuidar tu cuerpo.',
      emoji: '🌸',
    ),
    OnboardingPage(
      title: 'Ciclo + Ayuno Intermitente',
      description:
          'EVI combina el seguimiento de tu ciclo menstrual con recomendaciones personalizadas de ayuno intermitente, adaptadas a cada fase.',
      emoji: '🌙',
    ),
    OnboardingPage(
      title: 'Tu bienestar, nuestra prioridad',
      description:
          'Recibe recomendaciones suaves, entiende tu cuerpo y cuídate con respeto y empatía en cada momento de tu ciclo.',
      emoji: '💝',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _goToHome() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Indicador de página
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildPageIndicator(index == _currentPage),
                ),
              ),
            ),

            // Contenido de las páginas
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index]);
                },
              ),
            ),

            // Botón de acción
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: EviButton(
                label: _currentPage == _pages.length - 1
                    ? 'Comenzar'
                    : 'Siguiente',
                onPressed: _nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            page.emoji,
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            page.title,
            style: AppTextStyles.displayMedium(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            page.description,
            style: AppTextStyles.bodyLarge(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String emoji;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.emoji,
  });
}

