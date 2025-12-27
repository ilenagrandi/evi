# EVI - App de Seguimiento Menstrual y Ayuno Intermitente

EVI es una aplicación móvil delicada y empática desarrollada en Flutter que ayuda a las usuarias a:

- Llevar seguimiento del ciclo menstrual
- Entender en qué fase del ciclo se encuentran
- Recibir recomendaciones de horas de ayuno intermitente según la fase del ciclo
- Registrar síntomas y notas del día
- Y próximamente: notificaciones, pagos/suscripciones y gamificación

## 🏗️ Arquitectura

El proyecto sigue una arquitectura **feature-first + capas**:

```
lib/
├── app/                    # Configuración de la app
│   └── router/            # Configuración de rutas (go_router)
├── core/                   # Código compartido
│   ├── theme/             # Tema visual (colores, tipografías, spacing)
│   ├── widgets/           # Widgets reutilizables
│   ├── services/          # Interfaces y servicios mock
│   └── utils/             # Utilidades
└── features/              # Features organizadas por funcionalidad
    ├── onboarding/
    ├── cycle_tracking/
    │   ├── data/         # Repositorios, data sources, DTOs
    │   ├── domain/       # Entidades, use cases, repositorios abstractos
    │   └── presentation/ # Screens, widgets, providers
    ├── fasting/
    └── profile/
```

### Principios de Arquitectura

- **Separación de responsabilidades**: Domain → Data → Presentation
- **State Management**: Riverpod para manejo de estado
- **Routing**: go_router** para navegación declarativa
- **Sin lógica de negocio en Widgets**: Los widgets solo reaccionan al estado y llaman a acciones expuestas por controllers/use cases

## 🎨 Tema Visual

EVI utiliza una paleta de colores suaves, femeninos y calmados:

- **Primario**: Rosa claro (#F8BBD9)
- **Secundario**: Lila suave (#D4C5E8)
- **Acento**: Verde menta suave (#C8E6D5)
- **Tipografía**: Nunito (Google Fonts)

El tema está completamente configurado en `lib/core/theme/` y se puede personalizar fácilmente.

## 🚀 Inicio Rápido

### Prerrequisitos

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0

### Instalación

1. Clona el repositorio
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecuta la app:
   ```bash
   flutter run
   ```

## 📱 Pantallas Implementadas

### Onboarding
- 3 pantallas que explican qué es EVI y cómo funciona
- Navegación con indicadores de página
- Botón "Comenzar" que lleva al home

### Home
- Muestra el día actual del ciclo
- Indica la fase actual (Menstruación, Folicular, Ovulación, Lútea)
- Recomendación de ayuno para hoy
- Accesos rápidos a síntomas y ayuno

### Síntomas
- Lista de síntomas comunes con chips seleccionables
- Campo de texto para notas del día
- Guardado de síntomas (mock por ahora)

### Ayuno
- Recomendación de horas de ayuno según la fase
- Descripción de por qué esa recomendación
- Historial de los últimos 7 días

### Perfil
- Información del usuario
- Plan actual (Gratuito/Premium - placeholder)
- Preferencias de notificaciones
- Opciones adicionales

## 🔌 Integración con Backend

El proyecto está preparado para integrarse con un backend NestJS. Los servicios están definidos como interfaces en `lib/core/services/`:

- `CycleService`: Gestión del ciclo menstrual
- `FastingService`: Recomendaciones de ayuno
- `AuthService`: Autenticación
- `NotificationService`: Notificaciones push y locales

Actualmente, hay implementaciones mock en `lib/core/services/mock_*.dart` que permiten que la app funcione sin backend. Para conectar con el backend real:

1. Crea implementaciones reales de los servicios (ej: `lib/core/services/api_cycle_service.dart`)
2. Reemplaza los providers mock con las implementaciones reales
3. Los repositorios en `features/*/data/repositories/` ya están preparados para usar los servicios

## ➕ Cómo Agregar un Nuevo Feature

Sigue estos pasos para agregar una nueva funcionalidad:

### 1. Crear la estructura de carpetas

```
lib/features/nuevo_feature/
├── data/
│   └── repositories/
│       └── nuevo_feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── nuevo_feature_entity.dart
│   └── repositories/
│       └── nuevo_feature_repository.dart
└── presentation/
    ├── providers/
    │   └── nuevo_feature_provider.dart
    └── screens/
        └── nuevo_feature_screen.dart
```

### 2. Definir entidades en `domain/entities/`

```dart
// lib/features/nuevo_feature/domain/entities/nuevo_feature_entity.dart
import 'package:equatable/equatable.dart';

class NuevoFeatureEntity extends Equatable {
  const NuevoFeatureEntity({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
```

### 3. Definir repositorio abstracto en `domain/repositories/`

```dart
// lib/features/nuevo_feature/domain/repositories/nuevo_feature_repository.dart
import '../entities/nuevo_feature_entity.dart';

abstract class NuevoFeatureRepository {
  Future<List<NuevoFeatureEntity>> getItems();
  Future<void> saveItem(NuevoFeatureEntity item);
}
```

### 4. Implementar repositorio en `data/repositories/`

```dart
// lib/features/nuevo_feature/data/repositories/nuevo_feature_repository_impl.dart
import '../../domain/repositories/nuevo_feature_repository.dart';
import '../../domain/entities/nuevo_feature_entity.dart';
import '../../../../core/services/nuevo_feature_service.dart';

class NuevoFeatureRepositoryImpl implements NuevoFeatureRepository {
  final NuevoFeatureService _service;

  NuevoFeatureRepositoryImpl(this._service);

  @override
  Future<List<NuevoFeatureEntity>> getItems() async {
    // Lógica para obtener items usando el servicio
    return [];
  }

  @override
  Future<void> saveItem(NuevoFeatureEntity item) async {
    // Lógica para guardar usando el servicio
  }
}
```

### 5. Crear providers en `presentation/providers/`

```dart
// lib/features/nuevo_feature/presentation/providers/nuevo_feature_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/nuevo_feature_repository.dart';
import '../../data/repositories/nuevo_feature_repository_impl.dart';
import '../../../../core/services/mock_nuevo_feature_service.dart';

final nuevoFeatureRepositoryProvider = Provider<NuevoFeatureRepository>((ref) {
  final service = MockNuevoFeatureService();
  return NuevoFeatureRepositoryImpl(service);
});

final itemsProvider = FutureProvider<List<NuevoFeatureEntity>>((ref) async {
  final repository = ref.watch(nuevoFeatureRepositoryProvider);
  return repository.getItems();
});
```

### 6. Crear pantalla en `presentation/screens/`

```dart
// lib/features/nuevo_feature/presentation/screens/nuevo_feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nuevo_feature_provider.dart';

class NuevoFeatureScreen extends ConsumerWidget {
  const NuevoFeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Feature')),
      body: itemsAsync.when(
        data: (items) => ListView.builder(...),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
```

### 7. Agregar ruta en `lib/app/router/app_router.dart`

```dart
GoRoute(
  path: '/nuevo-feature',
  name: 'nuevo-feature',
  builder: (context, state) => const NuevoFeatureScreen(),
),
```

### 8. Crear servicio en `lib/core/services/` (si es necesario)

```dart
// lib/core/services/nuevo_feature_service.dart
abstract class NuevoFeatureService {
  Future<List<Map<String, dynamic>>> getItems();
  Future<void> saveItem(Map<String, dynamic> item);
}
```

Y su implementación mock:

```dart
// lib/core/services/mock_nuevo_feature_service.dart
import 'nuevo_feature_service.dart';

class MockNuevoFeatureService implements NuevoFeatureService {
  @override
  Future<List<Map<String, dynamic>>> getItems() async {
    return [];
  }

  @override
  Future<void> saveItem(Map<String, dynamic> item) async {
    // Mock implementation
  }
}
```

## 📦 Dependencias Principales

- `flutter_riverpod`: State management
- `go_router`: Routing declarativo
- `google_fonts`: Tipografías
- `equatable`: Comparación de objetos
- `intl`: Formateo de fechas y números

## 🎯 Próximos Pasos

- [ ] Integración con backend NestJS
- [ ] Sistema de notificaciones push
- [ ] Autenticación real
- [ ] Sistema de suscripciones
- [ ] Gamificación (streaks, logros)
- [ ] Historial completo de ciclos
- [ ] Gráficos y visualizaciones
- [ ] Exportación de datos

## 📝 Notas

- El proyecto usa **Riverpod** para state management de forma consistente
- **go_router** fue elegido por su naturaleza declarativa, type-safety y soporte para deep linking
- Todos los servicios están abstraídos para facilitar la integración futura con el backend
- El tema visual está completamente centralizado y es fácil de personalizar

## 🤝 Contribuir

Al agregar nuevas features, siempre respeta:
1. La arquitectura feature-first + capas
2. No poner lógica de negocio en Widgets
3. Usar Riverpod para state management
4. Mantener el estilo visual delicado y femenino de EVI
