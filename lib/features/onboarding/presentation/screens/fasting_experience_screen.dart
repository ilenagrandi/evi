import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 4: Experiencia con ayuno intermitente
class FastingExperienceScreen extends ConsumerStatefulWidget {
  const FastingExperienceScreen({super.key});

  @override
  ConsumerState<FastingExperienceScreen> createState() =>
      _FastingExperienceScreenState();
}

class _FastingExperienceScreenState
    extends ConsumerState<FastingExperienceScreen> {
  String? _selectedExperience;
  List<String> _selectedFastingTypes = [];

  final List<Map<String, String>> _experienceOptions = [
    {'value': 'never', 'label': 'Nunca lo he intentado'},
    {'value': 'tried', 'label': 'Lo he intentado, pero no de forma constante'},
    {'value': 'sometimes', 'label': 'Lo hago a veces'},
    {'value': 'often', 'label': 'Lo hago casi todos los días'},
    {'value': 'prefer-not-say', 'label': 'Prefiero no decir'},
  ];

  final List<Map<String, String>> _fastingTypes = [
    {'value': '12-14', 'label': '12–14 horas'},
    {'value': '16', 'label': '16 horas'},
    {'value': '16-plus', 'label': 'Más de 16 horas'},
    {'value': 'not-sure', 'label': 'No estoy segura'},
  ];

  void _onNext() {
    final notifier = ref.read(onboardingDataProvider.notifier);
    if (_selectedExperience != null) {
      notifier.updateFastingExperience(_selectedExperience);
    }
    if (_selectedFastingTypes.isNotEmpty) {
      notifier.updateFastingTypes(_selectedFastingTypes);
    }
    context.go('/onboarding/goals');
  }

  @override
  Widget build(BuildContext context) {
    final showFastingTypes = _selectedExperience != null &&
        _selectedExperience != 'never' &&
        _selectedExperience != 'prefer-not-say';

    return OnboardingBaseScreen(
      currentStep: 4,
      totalSteps: 7,
      title: '¿Has hecho ayuno intermitente antes? ⏳',
      subtitle: '',
      primaryButtonLabel: 'Siguiente',
      secondaryText:
          'EVI no te va a empujar a hacer cosas extremas. La idea es encontrar lo que tu cuerpo puede sostener con calma.',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/cycle-regularity'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opciones de experiencia
          ..._experienceOptions.map((option) {
            final isSelected = _selectedExperience == option['value'];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: EviCard(
                onTap: () {
                  setState(() {
                    _selectedExperience = option['value'];
                    if (option['value'] == 'never' ||
                        option['value'] == 'prefer-not-say') {
                      _selectedFastingTypes = [];
                    }
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
                        option['label']!,
                        style: AppTextStyles.titleMedium(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Pregunta extra sobre tipos de ayuno
          if (showFastingTypes) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              '¿Qué tipo de ayunos has hecho más?',
              style: AppTextStyles.titleMedium(),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _fastingTypes.map((type) {
                final isSelected = _selectedFastingTypes.contains(type['value']);
                return FilterChip(
                  selected: isSelected,
                  label: Text(type['label']!),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFastingTypes.add(type['value']!);
                      } else {
                        _selectedFastingTypes.remove(type['value']);
                      }
                    });
                  },
                  selectedColor: AppColors.primaryLight,
                  checkmarkColor: AppColors.primary,
                  labelStyle: AppTextStyles.bodyMedium(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
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
        ],
      ),
    );
  }
}

