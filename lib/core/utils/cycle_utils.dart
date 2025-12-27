/// Utilidades para trabajar con el ciclo menstrual
class CycleUtils {
  CycleUtils._();

  /// Fases del ciclo menstrual
  static const String phaseMenstruation = 'menstruation';
  static const String phaseFollicular = 'follicular';
  static const String phaseOvulation = 'ovulation';
  static const String phaseLuteal = 'luteal';

  /// Obtiene el nombre en español de una fase
  static String getPhaseName(String phase) {
    switch (phase) {
      case phaseMenstruation:
        return 'Menstruación';
      case phaseFollicular:
        return 'Fase Folicular';
      case phaseOvulation:
        return 'Ovulación';
      case phaseLuteal:
        return 'Fase Lútea';
      default:
        return 'Desconocida';
    }
  }

  /// Obtiene una descripción amigable de la fase
  static String getPhaseDescription(String phase) {
    switch (phase) {
      case phaseMenstruation:
        return 'Tu cuerpo se está renovando. Descansa y cuídate.';
      case phaseFollicular:
        return 'Tu energía está aumentando. Es un buen momento para nuevas actividades.';
      case phaseOvulation:
        return 'Estás en tu momento más fértil. Tu energía está en su punto máximo.';
      case phaseLuteal:
        return 'Tu cuerpo se prepara. Escucha sus señales y date tiempo.';
      default:
        return '';
    }
  }

  /// Calcula el día del ciclo basado en la fecha del último período
  static int calculateCycleDay(DateTime lastPeriodStart, DateTime today) {
    final difference = today.difference(lastPeriodStart).inDays;
    // Asumiendo un ciclo de 28 días (se puede hacer más dinámico después)
    return (difference % 28) + 1;
  }

  /// Determina la fase basada en el día del ciclo
  static String getPhaseByDay(int cycleDay) {
    if (cycleDay >= 1 && cycleDay <= 5) {
      return phaseMenstruation;
    } else if (cycleDay >= 6 && cycleDay <= 13) {
      return phaseFollicular;
    } else if (cycleDay >= 14 && cycleDay <= 16) {
      return phaseOvulation;
    } else {
      return phaseLuteal;
    }
  }
}

