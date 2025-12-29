import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/onboarding_data.dart';

/// Provider que mantiene el estado del onboarding
final onboardingDataProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingData>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<OnboardingData> {
  OnboardingNotifier() : super(const OnboardingData());

  void updateName(String? name) {
    state = state.copyWith(name: name);
  }

  void updateAgeRange(String? ageRange) {
    state = state.copyWith(ageRange: ageRange);
  }

  void updateLastPeriodDate(DateTime? date, {bool skip = false}) {
    state = state.copyWith(
      lastPeriodDate: date,
      skipLastPeriod: skip,
    );
  }

  void updateCycleRegularity(String? regularity) {
    state = state.copyWith(cycleRegularity: regularity);
  }

  void updateFastingExperience(String? experience) {
    state = state.copyWith(fastingExperience: experience);
  }

  void updateFastingTypes(List<String> types) {
    state = state.copyWith(fastingTypes: types);
  }

  void updateGoals(List<String> goals) {
    state = state.copyWith(goals: goals);
  }

  void updateCompanionshipStyle(String? style) {
    state = state.copyWith(companionshipStyle: style);
  }

  void updateNotificationFrequency(String? frequency) {
    state = state.copyWith(notificationFrequency: frequency);
  }

  void reset() {
    state = const OnboardingData();
  }
}


