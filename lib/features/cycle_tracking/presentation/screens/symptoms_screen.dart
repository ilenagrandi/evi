import 'package:flutter/material.dart';
import '../../../../core/widgets/evi_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/symptom.dart';

/// Pantalla para registrar síntomas y notas del día
class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  final TextEditingController _notesController = TextEditingController();
  final List<Symptom> _symptoms = [
    const Symptom(id: '1', name: 'Cansancio', emoji: '😴'),
    const Symptom(id: '2', name: 'Dolor', emoji: '😣'),
    const Symptom(id: '3', name: 'Buen ánimo', emoji: '😊'),
    const Symptom(id: '4', name: 'Hinchazón', emoji: '💧'),
    const Symptom(id: '5', name: 'Acné', emoji: '🔴'),
    const Symptom(id: '6', name: 'Dolor de cabeza', emoji: '🤕'),
    const Symptom(id: '7', name: 'Náuseas', emoji: '🤢'),
    const Symptom(id: '8', name: 'Sensibilidad', emoji: '💔'),
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _toggleSymptom(int index) {
    setState(() {
      _symptoms[index] = _symptoms[index].copyWith(
        isSelected: !_symptoms[index].isSelected,
      );
    });
  }

  void _saveSymptoms() {
    // En el futuro, esto guardará en el backend
    final selectedSymptoms = _symptoms.where((s) => s.isSelected).toList();
    // final notes = _notesController.text; // Se usará cuando se integre con backend

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Síntomas guardados: ${selectedSymptoms.length}',
        ),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar síntomas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Cómo te sientes hoy?',
                style: AppTextStyles.headlineMedium(),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Selecciona los síntomas que estés experimentando',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Grid de síntomas
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: List.generate(
                  _symptoms.length,
                  (index) => _buildSymptomChip(index),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Campo de notas
              Text(
                'Notas del día',
                style: AppTextStyles.titleLarge(),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _notesController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Escribe cómo te sientes, qué notas, o cualquier observación...',
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Botón guardar
              EviButton(
                label: 'Guardar',
                onPressed: _saveSymptoms,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomChip(int index) {
    final symptom = _symptoms[index];
    final isSelected = symptom.isSelected;

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(symptom.emoji),
          const SizedBox(width: AppSpacing.xs),
          Text(symptom.name),
        ],
      ),
      onSelected: (_) => _toggleSymptom(index),
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
  }
}

