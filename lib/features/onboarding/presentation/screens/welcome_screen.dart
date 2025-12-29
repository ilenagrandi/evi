import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 1: Bienvenida a EVI
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 1,
      totalSteps: 7,
      title: 'Bienvenida a EVI 🩷',
      subtitle:
          'EVI te ayuda a entender tu ciclo, cuidar tus hormonas y planear tus ayunos de forma amable con tu cuerpo.\n\nNada extremo, nada invasivo: solo decisiones más conscientes, paso a paso.',
      primaryButtonLabel: 'Empezar',
      secondaryText: 'Esto no reemplaza consejo médico profesional.',
      centerContent: true,
      onPrimaryButtonPressed: () {
        context.go('/onboarding/personal-info');
      },
      child: const SizedBox.shrink(),
    );
  }
}

