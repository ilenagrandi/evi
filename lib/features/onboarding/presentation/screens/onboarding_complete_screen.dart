import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 7: Resumen final
class OnboardingCompleteScreen extends ConsumerWidget {
  const OnboardingCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingData = ref.watch(onboardingDataProvider);
    final name = onboardingData.name;
    final greeting = name != null && name.isNotEmpty
        ? 'Todo listo, $name 💕'
        : 'Todo listo 🩷';

    void _onComplete() {
      // Aquí se guardaría la información en el backend
      // Por ahora, solo navegamos al home
      context.go('/home');
    }

    return OnboardingBaseScreen(
      currentStep: 7,
      totalSteps: 7,
      title: greeting,
      subtitle:
          'Con lo que me contaste, EVI va a:\n\n• adaptar tus recomendaciones de ayuno a tu fase del ciclo,\n• avisarte en los momentos clave,\n• ayudarte a cuidar tu energía y tus hormonas paso a paso.\n\nNo tienes que hacerlo perfecto, solo seguir escuchando a tu cuerpo.',
      primaryButtonLabel: 'Ir a mi panel',
      secondaryText:
          'Recuerda: EVI no reemplaza a tu médico. Es una guía suave para que tomes decisiones más informadas.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/companionship-style'),
      onPrimaryButtonPressed: _onComplete,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '¡Estás lista para comenzar!',
              style: AppTextStyles.headlineMedium(
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

