import 'package:equatable/equatable.dart';

/// Entidad que representa un síntoma
class Symptom extends Equatable {
  const Symptom({
    required this.id,
    required this.name,
    required this.emoji,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String emoji;
  final bool isSelected;

  Symptom copyWith({
    String? id,
    String? name,
    String? emoji,
    bool? isSelected,
  }) {
    return Symptom(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [id, name, emoji, isSelected];
}

