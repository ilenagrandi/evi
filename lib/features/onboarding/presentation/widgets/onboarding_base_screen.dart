import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/evi_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Widget base para las pantallas de onboarding
class OnboardingBaseScreen extends StatelessWidget {
  const OnboardingBaseScreen({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.primaryButtonLabel,
    required this.onPrimaryButtonPressed,
    this.secondaryText,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerContent = false,
  });

  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;
  final Widget child;
  final String primaryButtonLabel;
  final VoidCallback onPrimaryButtonPressed;
  final String? secondaryText;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Indicador de progreso
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Row(
                children: [
                  if (showBackButton)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: onBackPressed ?? () => _handleBackNavigation(context),
                      color: AppColors.textPrimary,
                    ),
                  const Spacer(),
                  Text(
                    '$currentStep/$totalSteps',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Barra de progreso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: LinearProgressIndicator(
                value: currentStep / totalSteps,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Contenido
            Expanded(
              child: centerContent
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenPadding,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                                minWidth: constraints.maxWidth,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Título
                                  Text(
                                    title,
                                    style: AppTextStyles.displayMedium(),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppSpacing.md),

                                  // Subtítulo
                                  Text(
                                    subtitle,
                                    style: AppTextStyles.bodyLarge(
                                      color: AppColors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppSpacing.xl),

                                  // Contenido específico de la pantalla
                                  child,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título
                          Text(
                            title,
                            style: AppTextStyles.displayMedium(),
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Subtítulo
                          Text(
                            subtitle,
                            style: AppTextStyles.bodyLarge(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Contenido específico de la pantalla
                          child,
                        ],
                      ),
                    ),
            ),

            // Botón y texto secundario
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                children: [
                  EviButton(
                    label: primaryButtonLabel,
                    onPressed: onPrimaryButtonPressed,
                  ),
                  if (secondaryText != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      secondaryText!,
                      style: AppTextStyles.caption(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    // Mapeo de rutas según el paso actual
    final routes = [
      '/onboarding', // paso 1
      '/onboarding/personal-info', // paso 2
      '/onboarding/last-period', // paso 3
      '/onboarding/cycle-regularity', // paso 3B
      '/onboarding/fasting-experience', // paso 4
      '/onboarding/goals', // paso 5
      '/onboarding/companionship-style', // paso 6
      '/onboarding/complete', // paso 7
    ];

    // Si estamos en el paso 1, no hay dónde volver
    if (currentStep <= 1) {
      return;
    }

    // Navegar al paso anterior
    final previousStep = currentStep - 1;
    if (previousStep > 0 && previousStep < routes.length) {
      context.go(routes[previousStep - 1]);
    }
  }
}

