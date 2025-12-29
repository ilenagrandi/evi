import 'package:flutter/material.dart';
import '../../../../core/widgets/evi_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

/// Pantalla de perfil y ajustes
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  String _currentPlan = 'Gratuito';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del usuario
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: EviCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primaryLight,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usuario',
                            style: AppTextStyles.headlineSmall(),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'usuario@evi.app',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Plan actual
            SectionHeader(
              title: 'Plan actual',
              subtitle: 'Tu suscripción actual',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: EviCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSmall),
                      ),
                      child: const Icon(
                        Icons.star_outline,
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
                            _currentPlan,
                            style: AppTextStyles.titleLarge(),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Acceso a funciones básicas',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // En el futuro, esto abrirá la pantalla de suscripciones
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Próximamente: gestión de suscripciones'),
                          ),
                        );
                      },
                      child: const Text('Ver planes'),
                    ),
                  ],
                ),
              ),
            ),

            // Preferencias
            SectionHeader(
              title: 'Preferencias',
              subtitle: 'Configura tus notificaciones',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: EviCard(
                child: SwitchListTile(
                  title: Text(
                    'Notificaciones',
                    style: AppTextStyles.titleMedium(),
                  ),
                  subtitle: Text(
                    'Recibe recordatorios sobre tu ciclo y ayuno',
                    style: AppTextStyles.bodySmall(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    // En el futuro, esto actualizará las preferencias en el backend
                  },
                  activeColor: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Más opciones
            SectionHeader(
              title: 'Más opciones',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    icon: Icons.history,
                    title: 'Historial',
                    subtitle: 'Ver tu historial completo',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Próximamente: historial completo'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildOptionTile(
                    icon: Icons.help_outline,
                    title: 'Ayuda',
                    subtitle: 'Preguntas frecuentes y soporte',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Próximamente: centro de ayuda'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildOptionTile(
                    icon: Icons.info_outline,
                    title: 'Acerca de',
                    subtitle: 'Versión 1.0.0',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Acerca de EVI'),
                          content: const Text(
                            'EVI es una app delicada y empática que te ayuda a entender y cuidar tu cuerpo durante cada fase de tu ciclo menstrual.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return EviCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleMedium(),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall(
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
    );
  }
}


