import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 5: Objetivos principales
class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  final List<String> _selectedGoals = [];
  final TextEditingController _otherGoalController = TextEditingController();
  bool _showOtherField = false;

  final List<Map<String, String>> _goals = [
    {'value': 'more-energy', 'label': 'Más energía durante el día'},
    {'value': 'better-food-relationship', 'label': 'Mejorar mi relación con la comida'},
    {'value': 'improve-pms', 'label': 'Mejorar síntomas del síndrome premenstrual'},
    {'value': 'healthy-fat-loss', 'label': 'Apoyar la pérdida de grasa de forma saludable'},
    {'value': 'better-sleep', 'label': 'Dormir mejor'},
    {'value': 'connect-cycle', 'label': 'Conectar más con mi ciclo y mis hormonas'},
  ];

  @override
  void dispose() {
    _otherGoalController.dispose();
    super.dispose();
  }

  void _onNext() {
    final notifier = ref.read(onboardingDataProvider.notifier);
    final goals = List<String>.from(_selectedGoals);
    if (_showOtherField && _otherGoalController.text.isNotEmpty) {
      goals.add('other:${_otherGoalController.text}');
    }
    notifier.updateGoals(goals);
    context.go('/onboarding/companionship-style');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 5,
      totalSteps: 7,
      title: '¿Qué te gustaría mejorar con EVI? 🎯',
      subtitle: 'Puedes elegir una o varias opciones.',
      primaryButtonLabel: 'Siguiente',
      secondaryText:
          'No hay respuestas "correctas". EVI está para acompañarte, no para juzgarte.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/fasting-experience'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips de objetivos
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _goals.map((goal) {
              final isSelected = _selectedGoals.contains(goal['value']);
              return FilterChip(
                selected: isSelected,
                label: Text(goal['label']!),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedGoals.add(goal['value']!);
                    } else {
                      _selectedGoals.remove(goal['value']);
                    }
                  });
                },
                selectedColor: AppColors.primaryLight,
                checkmarkColor: AppColors.primary,
                labelStyle: AppTextStyles.bodyMedium(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // Opción "Otra cosa"
          FilterChip(
            selected: _showOtherField,
            label: const Text('Otra cosa'),
            onSelected: (selected) {
              setState(() {
                _showOtherField = selected;
                if (!selected) {
                  _otherGoalController.clear();
                }
              });
            },
            selectedColor: AppColors.primaryLight,
            checkmarkColor: AppColors.primary,
            labelStyle: AppTextStyles.bodyMedium(
              color: _showOtherField ? AppColors.primary : AppColors.textPrimary,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              side: BorderSide(
                color: _showOtherField ? AppColors.primary : AppColors.border,
                width: _showOtherField ? 2 : 1,
              ),
            ),
          ),

          // Campo de texto para "otra cosa"
          if (_showOtherField) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _otherGoalController,
              decoration: const InputDecoration(
                hintText: 'Cuéntanos qué te gustaría mejorar...',
              ),
              maxLines: 2,
            ),
          ],
        ],
      ),
    );
  }
}

