import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/onboarding_base_screen.dart';
import '../providers/onboarding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla 3A: Último periodo
class LastPeriodScreen extends ConsumerStatefulWidget {
  const LastPeriodScreen({super.key});

  @override
  ConsumerState<LastPeriodScreen> createState() => _LastPeriodScreenState();
}

class _LastPeriodScreenState extends ConsumerState<LastPeriodScreen> {
  DateTime? _selectedDate;
  bool _skipPeriod = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 14)),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _skipPeriod = false;
      });
    }
  }

  void _onNext() {
    final notifier = ref.read(onboardingDataProvider.notifier);
    if (_skipPeriod) {
      notifier.updateLastPeriodDate(null, skip: true);
    } else if (_selectedDate != null) {
      notifier.updateLastPeriodDate(_selectedDate);
    }
    context.go('/onboarding/cycle-regularity');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBaseScreen(
      currentStep: 3,
      totalSteps: 7,
      title: 'Sobre tu ciclo menstrual 🌙',
      subtitle:
          'EVI adapta todo a tu ciclo: no es lo mismo ayunar en cada fase.\n\nEmpecemos por algo simple:',
      primaryButtonLabel: 'Siguiente',
      showBackButton: true,
      onBackPressed: () => context.go('/onboarding/personal-info'),
      onPrimaryButtonPressed: _onNext,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Cuándo fue el primer día de tu último periodo?',
            style: AppTextStyles.titleLarge(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Selector de fecha
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : 'Selecciona una fecha',
                    style: AppTextStyles.bodyMedium(
                      color: _selectedDate != null
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Checkbox para saltar
          CheckboxListTile(
            value: _skipPeriod,
            onChanged: (value) {
              setState(() {
                _skipPeriod = value ?? false;
                if (_skipPeriod) {
                  _selectedDate = null;
                }
              });
            },
            title: Text(
              'No me acuerdo / Prefiero saltar este paso ahora',
              style: AppTextStyles.bodyMedium(),
            ),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

