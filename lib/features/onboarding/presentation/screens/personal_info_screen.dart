import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 2: Información personal (nombre + edad)
class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedAgeRange;

  final List<Map<String, String>> _ageRanges = [
    {'value': 'under-18', 'label': 'Menos de 18'},
    {'value': '18-24', 'label': '18–24'},
    {'value': '25-34', 'label': '25–34'},
    {'value': '35-44', 'label': '35–44'},
    {'value': '45-plus', 'label': '45 o más'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_nameController.text.isNotEmpty) {
      ref.read(onboardingDataProvider.notifier).updateName(_nameController.text);
    }
    if (_selectedAgeRange != null) {
      ref.read(onboardingDataProvider.notifier).updateAgeRange(_selectedAgeRange);
    }
    context.go('/onboarding/last-period');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 2,
      totalSteps: 7,
      title: 'Primero, hablemos de ti ✨',
      subtitle:
          'Para acompañarte mejor, necesito saber un poquito más de ti.',
      primaryButtonLabel: 'Siguiente',
      secondaryText: 'Tus datos son privados. Solo los usamos para ajustar tus recomendaciones.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de nombre
          Text(
            '¿Cómo te gustaría que te llame?',
            style: AppTextStyles.titleMedium(),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Ej: Ana',
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Selector de edad
          Text(
            '¿Qué edad tienes?',
            style: AppTextStyles.titleMedium(),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _ageRanges.map((ageRange) {
              final isSelected = _selectedAgeRange == ageRange['value'];
              return FilterChip(
                selected: isSelected,
                label: Text(ageRange['label']!),
                onSelected: (selected) {
                  setState(() {
                    _selectedAgeRange = selected ? ageRange['value'] : null;
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
        ],
      ),
    );
  }
}

