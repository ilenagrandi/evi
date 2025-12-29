import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 3B: Regularidad del ciclo
class CycleRegularityScreen extends ConsumerStatefulWidget {
  const CycleRegularityScreen({super.key});

  @override
  ConsumerState<CycleRegularityScreen> createState() =>
      _CycleRegularityScreenState();
}

class _CycleRegularityScreenState extends ConsumerState<CycleRegularityScreen> {
  String? _selectedRegularity;

  final List<Map<String, String>> _regularityOptions = [
    {
      'value': 'regular',
      'label': 'Bastante regular',
      'description': 'Casi siempre cada 26–32 días',
    },
    {
      'value': 'somewhat-irregular',
      'label': 'Algo irregular',
      'description': 'Varía bastante',
    },
    {
      'value': 'very-irregular',
      'label': 'Muy irregular o no estoy segura',
      'description': '',
    },
    {
      'value': 'no-cycle',
      'label': 'No tengo ciclo actualmente',
      'description': 'Embarazo, lactancia, menopausia, anticonceptivos, etc.',
    },
  ];

  void _onNext() {
    if (_selectedRegularity != null) {
      ref
          .read(onboardingDataProvider.notifier)
          .updateCycleRegularity(_selectedRegularity);
    }
    context.go('/onboarding/fasting-experience');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 3,
      totalSteps: 7,
      title: '¿Qué tan regular es tu ciclo?',
      subtitle:
          'No pasa nada si tu ciclo no es "perfecto". EVI también está para eso.',
      primaryButtonLabel: 'Siguiente',
      secondaryText:
          'Si tienes condiciones especiales (como SOP, endometriosis, etc.), este es solo un primer paso. Más adelante podrás contarnos más.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/last-period'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        children: _regularityOptions.map((option) {
          final isSelected = _selectedRegularity == option['value'];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: EviCard(
              onTap: () {
                setState(() {
                  _selectedRegularity = option['value'];
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
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                      color: isSelected ? AppColors.primary : Colors.transparent,
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
                          option['label']!,
                          style: AppTextStyles.titleMedium(),
                        ),
                        if (option['description']!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            option['description']!,
                            style: AppTextStyles.bodySmall(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

