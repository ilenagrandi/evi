# 🚀 Guía de Despliegue a App Stores - EVI

Esta guía explica cómo preparar y subir la aplicación EVI a Google Play Store y Apple App Store.

## 📋 Tabla de Contenidos

1. [Preparación](#preparación)
2. [Configuración de Producción](#configuración-de-producción)
3. [Build para Android](#build-para-android)
4. [Build para iOS](#build-para-ios)
5. [Subida a App Stores](#subida-a-app-stores)
6. [CI/CD (Opcional)](#cicd-opcional)

## 🔧 Preparación

### 1. Verificar Requisitos

**Para Android:**
- ✅ Flutter SDK instalado
- ✅ Android Studio instalado
- ✅ Cuenta de Google Play Developer ($25 USD, pago único)
- ✅ Keystore configurado para firmar la app

**Para iOS:**
- ✅ macOS con Xcode instalado
- ✅ Cuenta de Apple Developer ($99 USD/año)
- ✅ Certificados y perfiles de aprovisionamiento configurados

### 2. Configurar Variables de Producción

1. Copia el archivo de ejemplo:
   ```bash
   cp .env.production.example .env.production
   ```

2. Edita `.env.production` con tus valores reales:
   ```env
   DEV=false
   API_BASE_URL=https://api.evi.app
   ```

3. **⚠️ IMPORTANTE**: Asegúrate de que `.env.production` esté en `.gitignore`

## 🏗️ Configuración de Producción

### Actualizar EnvConfig para Producción

El archivo `lib/core/config/env_config.dart` ya está configurado para leer variables de entorno. En producción, estas se pasan durante el build.

### Valores por Defecto Seguros

El código tiene valores por defecto que son seguros para desarrollo, pero en producción siempre debes especificar explícitamente:

```dart
// En producción, estos valores NO se usarán si pasas --dart-define
static const bool dev = bool.fromEnvironment('DEV', defaultValue: true);
static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
```

## 🤖 Build para Android

### Opción 1: Usar el Script Automatizado

```bash
./build_production.sh android
```

El script te preguntará si quieres construir:
- **APK**: Para testing interno
- **AAB**: Para Google Play Store (recomendado)

### Opción 2: Build Manual

#### 1. Configurar Keystore (Primera vez)

```bash
# Crear el keystore
keytool -genkey -v -keystore ~/evi-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias evi

# Guarda la contraseña de forma segura
```

#### 2. Configurar `android/key.properties`

Crea el archivo `android/key.properties`:

```properties
storePassword=tu_contraseña_del_keystore
keyPassword=tu_contraseña_de_la_key
keyAlias=evi
storeFile=/ruta/completa/a/evi-keystore.jks
```

**⚠️ IMPORTANTE**: Agrega `android/key.properties` a `.gitignore`

#### 3. Actualizar `android/app/build.gradle.kts`

Agrega la configuración de signing. Ver ejemplo en la sección de configuración avanzada.

#### 4. Construir el AAB

```bash
# Cargar variables de producción
source <(grep -v '^#' .env.production | sed 's/^/export /')

# Construir AAB
flutter build appbundle --release \
  --dart-define=DEV=false \
  --dart-define=API_BASE_URL=$API_BASE_URL
```

El archivo se generará en: `build/app/outputs/bundle/release/app-release.aab`

### Verificar el Build

```bash
# Verificar el AAB
bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=app.apks
```

## 🍎 Build para iOS

### Opción 1: Usar el Script Automatizado

```bash
./build_production.sh ios
```

### Opción 2: Build Manual con Xcode

#### 1. Configurar Certificados y Perfiles

1. Abre Xcode
2. Selecciona el proyecto `Runner`
3. Ve a "Signing & Capabilities"
4. Selecciona tu equipo de desarrollo
5. Xcode generará automáticamente los certificados y perfiles

#### 2. Construir desde la Terminal

```bash
# Cargar variables de producción
source <(grep -v '^#' .env.production | sed 's/^/export /')

# Construir para iOS
flutter build ios --release \
  --dart-define=DEV=false \
  --dart-define=API_BASE_URL=$API_BASE_URL
```

#### 3. Crear Archive en Xcode

1. Abre `ios/Runner.xcworkspace` en Xcode
2. Selecciona "Any iOS Device" como destino
3. Product > Archive
4. Espera a que termine el proceso

## 📤 Subida a App Stores

### Google Play Store

1. **Accede a Google Play Console**
   - Ve a: https://play.google.com/console
   - Inicia sesión con tu cuenta de desarrollador

2. **Crea la App (Primera vez)**
   - Click en "Crear aplicación"
   - Completa la información básica
   - Acepta los términos

3. **Sube el AAB**
   - Ve a "Producción" > "Crear versión"
   - Sube el archivo `app-release.aab`
   - Completa las notas de versión
   - Revisa y publica

4. **Completa la Información de la Tienda**
   - Descripción corta y larga
   - Capturas de pantalla
   - Icono de la app
   - Categoría y clasificación de contenido

### Apple App Store

1. **Accede a App Store Connect**
   - Ve a: https://appstoreconnect.apple.com
   - Inicia sesión con tu cuenta de desarrollador

2. **Crea la App (Primera vez)**
   - Click en "Mis Apps" > "+"
   - Completa la información básica
   - Bundle ID debe coincidir con el de Xcode

3. **Sube el Build desde Xcode**
   - En Xcode, después de crear el Archive:
   - Click en "Distribute App"
   - Selecciona "App Store Connect"
   - Sigue el asistente
   - Espera a que se procese (puede tardar varios minutos)

4. **Completa la Información de la Tienda**
   - Descripción
   - Capturas de pantalla
   - Icono
   - Categoría
   - Información de privacidad

5. **Envía para Revisión**
   - Selecciona el build procesado
   - Completa la información de exportación (si aplica)
   - Envía para revisión

## 🔄 CI/CD (Opcional)

### GitHub Actions

Crea `.github/workflows/build.yml`:

```yaml
name: Build and Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      
      - name: Build AAB
        run: |
          flutter build appbundle --release \
            --dart-define=DEV=false \
            --dart-define=API_BASE_URL=${{ secrets.API_BASE_URL }}
      
      - name: Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT }}
          packageName: com.example.evi
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      
      - name: Build iOS
        run: |
          flutter build ios --release \
            --dart-define=DEV=false \
            --dart-define=API_BASE_URL=${{ secrets.API_BASE_URL }}
      
      - name: Upload to App Store
        uses: apple-actions/upload-testflight-build@v1
        with:
          app-path: build/ios/ipa/evi.ipa
          issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
          api-key-id: ${{ secrets.APPSTORE_API_KEY_ID }}
          api-private-key: ${{ secrets.APPSTORE_API_PRIVATE_KEY }}
```

### Variables de Entorno en CI/CD

**GitHub Secrets:**
- `API_BASE_URL`: URL de producción
- `GOOGLE_PLAY_SERVICE_ACCOUNT`: JSON del service account
- `APPSTORE_ISSUER_ID`: ID del issuer de App Store Connect
- `APPSTORE_API_KEY_ID`: ID de la API key
- `APPSTORE_API_PRIVATE_KEY`: Clave privada de la API key

## 🔒 Seguridad

### ⚠️ NUNCA subas al repositorio:
- `.env.production` (con valores reales)
- `android/key.properties`
- `evi-keystore.jks` o cualquier keystore
- Certificados y claves privadas

### ✅ SÍ puedes subir:
- `.env.production.example` (sin valores reales)
- Scripts de build
- Documentación

### Mejores Prácticas:

1. **Usa servicios de gestión de secretos** para CI/CD:
   - GitHub Secrets
   - GitLab CI/CD Variables
   - AWS Secrets Manager
   - Google Secret Manager

2. **Rota las claves regularmente**

3. **Usa diferentes entornos**:
   - Desarrollo: `.env`
   - Staging: `.env.staging`
   - Producción: `.env.production`

## 📝 Checklist Pre-Lanzamiento

- [ ] Variables de producción configuradas correctamente
- [ ] Build probado en dispositivo real
- [ ] API de producción funcionando
- [ ] Notificaciones configuradas (si aplica)
- [ ] Analytics configurado (si aplica)
- [ ] Política de privacidad actualizada
- [ ] Términos de servicio actualizados
- [ ] Capturas de pantalla preparadas
- [ ] Descripción de la app escrita
- [ ] Icono de la app preparado
- [ ] Versión actualizada en `pubspec.yaml`
- [ ] Changelog preparado

## 🆘 Solución de Problemas

### Error: "Keystore file not found"
- Verifica que la ruta en `android/key.properties` sea correcta
- Asegúrate de usar rutas absolutas

### Error: "No valid code signing certificates found"
- Abre Xcode y verifica los certificados
- Regenera los certificados si es necesario

### Error: "API_BASE_URL not defined"
- Verifica que estés pasando `--dart-define=API_BASE_URL=...`
- Revisa el archivo `.env.production`

### Build de iOS falla
- Verifica que tengas Xcode Command Line Tools instalado: `xcode-select --install`
- Limpia el build: `flutter clean`
- Reconstruye: `flutter build ios --release`

## 📚 Recursos Adicionales

- [Flutter Deployment Guide](https://docs.flutter.dev/deployment)
- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
- [Flutter CI/CD Examples](https://github.com/flutter/flutter/tree/main/examples)

