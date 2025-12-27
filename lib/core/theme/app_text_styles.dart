import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Estilos de texto consistentes para EVI
class AppTextStyles {
  AppTextStyles._();

  // Fuente base - Nunito (suave y moderna)
  static TextStyle _baseStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      height: height,
    );
  }

  // Títulos
  static TextStyle displayLarge({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle displayMedium({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle displaySmall({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }

  // Títulos de sección
  static TextStyle headlineLarge({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle headlineMedium({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle headlineSmall({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.4,
    );
  }

  // Subtítulos
  static TextStyle titleLarge({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle titleMedium({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle titleSmall({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.5,
    );
  }

  // Texto de cuerpo
  static TextStyle bodyLarge({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.6,
    );
  }

  static TextStyle bodyMedium({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.6,
    );
  }

  static TextStyle bodySmall({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.6,
    );
  }

  // Captions y labels
  static TextStyle labelLarge({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle labelMedium({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle labelSmall({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle caption({
    Color? color,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textSecondary,
      height: 1.5,
    );
  }
}

