import 'package:equatable/equatable.dart';

/// Modelo de datos para el onboarding
class OnboardingData extends Equatable {
  const OnboardingData({
    this.name,
    this.ageRange,
    this.lastPeriodDate,
    this.skipLastPeriod = false,
    this.cycleRegularity,
    this.fastingExperience,
    this.fastingTypes,
    this.goals,
    this.companionshipStyle,
    this.notificationFrequency,
  });

  final String? name;
  final String? ageRange; // "under-18", "18-24", "25-34", "35-44", "45-plus"
  final DateTime? lastPeriodDate;
  final bool skipLastPeriod;
  final String? cycleRegularity; // "regular", "somewhat-irregular", "very-irregular", "no-cycle"
  final String? fastingExperience; // "never", "tried", "sometimes", "often", "prefer-not-say"
  final List<String>? fastingTypes; // ["12-14", "16", "16-plus", "not-sure"]
  final List<String>? goals; // Lista de objetivos seleccionados
  final String? companionshipStyle; // "gentle", "balanced", "structured"
  final String? notificationFrequency; // "rarely", "sometimes", "frequent"

  OnboardingData copyWith({
    String? name,
    String? ageRange,
    DateTime? lastPeriodDate,
    bool? skipLastPeriod,
    String? cycleRegularity,
    String? fastingExperience,
    List<String>? fastingTypes,
    List<String>? goals,
    String? companionshipStyle,
    String? notificationFrequency,
  }) {
    return OnboardingData(
      name: name ?? this.name,
      ageRange: ageRange ?? this.ageRange,
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
      skipLastPeriod: skipLastPeriod ?? this.skipLastPeriod,
      cycleRegularity: cycleRegularity ?? this.cycleRegularity,
      fastingExperience: fastingExperience ?? this.fastingExperience,
      fastingTypes: fastingTypes ?? this.fastingTypes,
      goals: goals ?? this.goals,
      companionshipStyle: companionshipStyle ?? this.companionshipStyle,
      notificationFrequency: notificationFrequency ?? this.notificationFrequency,
    );
  }

  @override
  List<Object?> get props => [
        name,
        ageRange,
        lastPeriodDate,
        skipLastPeriod,
        cycleRegularity,
        fastingExperience,
        fastingTypes,
        goals,
        companionshipStyle,
        notificationFrequency,
      ];
}


