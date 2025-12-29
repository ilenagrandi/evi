import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/fasting_provider.dart';
import '../../../../core/services/fasting_service.dart';

/// Pantalla de ayuno intermitente con recomendaciones y progreso
class FastingScreen extends ConsumerWidget {
  const FastingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationAsync = ref.watch(fastingRecommendationProvider);
    final historyAsync = ref.watch(fastingHistoryProvider(7));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi ayuno'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de recomendación actual
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: recommendationAsync.when(
                data: (recommendation) => _buildRecommendationCard(recommendation),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => _buildErrorCard(),
              ),
            ),

            // Historial reciente
            SectionHeader(
              title: 'Historial reciente',
              subtitle: 'Últimos 7 días',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: historyAsync.when(
                data: (history) => _buildHistoryList(history),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => _buildErrorCard(),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(recommendation) {
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
                  size: 32,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendación de hoy',
                      style: AppTextStyles.titleLarge(),
                    ),
                    Text(
                      recommendation.phase,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: Column(
              children: [
                Text(
                  '${recommendation.hours}',
                  style: AppTextStyles.displayLarge(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'horas',
                  style: AppTextStyles.titleMedium(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
            ),
            child: Text(
              recommendation.description,
              style: AppTextStyles.bodyMedium(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<FastingRecord> history) {
    if (history.isEmpty) {
      return EviCard(
        child: Center(
          child: Text(
            'No hay historial disponible',
            style: AppTextStyles.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: history.map((record) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: EviCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(record.date),
                        style: AppTextStyles.titleMedium(),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${record.hours} horas recomendadas',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  record.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: record.completed ? AppColors.success : AppColors.textTertiary,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrorCard() {
    return EviCard(
      child: Center(
        child: Text(
          'No se pudo cargar la información',
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Hoy';
    } else if (difference == 1) {
      return 'Ayer';
    } else if (difference < 7) {
      return 'Hace $difference días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}


