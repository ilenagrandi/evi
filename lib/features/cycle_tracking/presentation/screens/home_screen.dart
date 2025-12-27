import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/cycle_utils.dart';
import '../providers/cycle_provider.dart';
import '../../../../features/fasting/presentation/providers/fasting_provider.dart';

/// Pantalla principal que muestra el estado del ciclo y recomendaciones
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycleInfoAsync = ref.watch(currentCycleInfoProvider);
    final fastingHoursAsync = ref.watch(fastingHoursForTodayProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EVI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card del ciclo actual
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: cycleInfoAsync.when(
                data: (cycleInfo) => _buildCycleCard(cycleInfo),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => _buildErrorCard(),
              ),
            ),

            // Card de recomendación de ayuno
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: fastingHoursAsync.when(
                data: (hours) => _buildFastingCard(context, hours),
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => const SizedBox.shrink(),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Sección de acciones rápidas
            SectionHeader(
              title: 'Acciones rápidas',
              subtitle: 'Registra cómo te sientes hoy',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: EviCard(
                onTap: () => context.go('/symptoms'),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_outline,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registrar síntomas',
                            style: AppTextStyles.titleLarge(),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Anota cómo te sientes hoy',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: EviCard(
                onTap: () => context.go('/fasting'),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.accent,
                      size: 32,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mi ayuno',
                            style: AppTextStyles.titleLarge(),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Revisa tus recomendaciones',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleCard(cycleInfo) {
    final phaseName = CycleUtils.getPhaseName(cycleInfo.phase);

    return EviCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Día $phaseName',
                      style: AppTextStyles.headlineSmall(),
                    ),
                    Text(
                      'Día ${cycleInfo.currentDay} de tu ciclo',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cycleInfo.phaseDescription,
                    style: AppTextStyles.bodyMedium(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFastingCard(BuildContext context, int hours) {
    return EviCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                ),
                child: const Icon(
                  Icons.access_time,
                  color: AppColors.accent,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendación de ayuno',
                      style: AppTextStyles.headlineSmall(),
                    ),
                    Text(
                      'Para tu fase actual',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '$hours horas',
            style: AppTextStyles.displaySmall(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Esta es la recomendación de ayuno intermitente para tu fase actual del ciclo.',
            style: AppTextStyles.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard() {
    return EviCard(
      child: Center(
        child: Text(
          'No se pudo cargar la información del ciclo',
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

