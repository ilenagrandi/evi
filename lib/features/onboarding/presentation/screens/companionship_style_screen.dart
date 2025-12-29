import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 6: Estilo de acompañamiento + notificaciones
class CompanionshipStyleScreen extends ConsumerStatefulWidget {
  const CompanionshipStyleScreen({super.key});

  @override
  ConsumerState<CompanionshipStyleScreen> createState() =>
      _CompanionshipStyleScreenState();
}

class _CompanionshipStyleScreenState
    extends ConsumerState<CompanionshipStyleScreen> {
  String? _selectedStyle;
  String? _selectedFrequency;

  final List<Map<String, String>> _styles = [
    {
      'value': 'gentle',
      'label': 'Muy suave',
      'description': 'Recordatorios mínimos, enfoque en calma',
    },
    {
      'value': 'balanced',
      'label': 'Equilibrado',
      'description': 'Recordatorios amables y motivación ligera',
    },
    {
      'value': 'structured',
      'label': 'Más estructurado',
      'description': 'Me gusta que me recuerden mis objetivos',
    },
  ];

  final List<Map<String, String>> _frequencies = [
    {'value': 'rarely', 'label': 'Casi nunca (solo lo esencial)'},
    {'value': 'sometimes', 'label': 'A veces (cuando sea importante)'},
    {'value': 'frequent', 'label': 'Frecuente (me gusta que me acompañen)'},
  ];

  void _onNext() {
    final notifier = ref.read(onboardingDataProvider.notifier);
    if (_selectedStyle != null) {
      notifier.updateCompanionshipStyle(_selectedStyle);
    }
    if (_selectedFrequency != null) {
      notifier.updateNotificationFrequency(_selectedFrequency);
    }
    context.go('/onboarding/complete');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 6,
      totalSteps: 7,
      title: '¿Cómo prefieres que te acompañe EVI? 🕊️',
      subtitle: '',
      primaryButtonLabel: 'Siguiente',
      secondaryText: 'Siempre podrás cambiar esto en Ajustes.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/goals'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Estilo de acompañamiento
          Text(
            'Elige el estilo que más va contigo:',
            style: AppTextStyles.titleLarge(),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._styles.map((style) {
            final isSelected = _selectedStyle == style['value'];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: EviCard(
                onTap: () {
                  setState(() {
                    _selectedStyle = style['value'];
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: AppColors.surface,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style['label']!,
                            style: AppTextStyles.titleMedium(),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            style['description']!,
                            style: AppTextStyles.bodySmall(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.xl),

          // Frecuencia de notificaciones
          Text(
            '¿Con qué frecuencia te gustaría recibir recordatorios?',
            style: AppTextStyles.titleLarge(),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._frequencies.map((frequency) {
            final isSelected = _selectedFrequency == frequency['value'];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: EviCard(
                onTap: () {
                  setState(() {
                    _selectedFrequency = frequency['value'];
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: AppColors.surface,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        frequency['label']!,
                        style: AppTextStyles.titleMedium(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

