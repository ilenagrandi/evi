# 🚀 Despliegue Rápido - EVI

Guía rápida para desplegar EVI a los app stores.

## ⚡ Inicio Rápido

### 1. Configurar Producción

```bash
# Copiar plantilla
cp .env.production.example .env.production

# Editar con tus valores reales
nano .env.production  # o usa tu editor preferido
```

**Valores mínimos requeridos:**
```env
DEV=false
API_BASE_URL=https://api.evi.app
```

### 2. Build y Subir

#### Android (Google Play Store)

```bash
# Opción 1: Script automatizado
./build_production.sh android

# Opción 2: Manual
flutter build appbundle --release \
  --dart-define=DEV=false \
  --dart-define=API_BASE_URL=https://api.evi.app
```

Luego sube el AAB a [Google Play Console](https://play.google.com/console).

#### iOS (App Store)

```bash
# Opción 1: Script automatizado
./build_production.sh ios

# Opción 2: Manual
flutter build ios --release \
  --dart-define=DEV=false \
  --dart-define=API_BASE_URL=https://api.evi.app
```

Luego abre Xcode y crea el Archive:
1. Abre `ios/Runner.xcworkspace`
2. Product > Archive
3. Distribute App > App Store Connect

## 📋 Checklist Pre-Lanzamiento

- [ ] `.env.production` configurado con valores reales
- [ ] API de producción funcionando
- [ ] App probada en dispositivo real
- [ ] Versión actualizada en `pubspec.yaml`
- [ ] Keystore configurado (Android)
- [ ] Certificados configurados (iOS)
- [ ] Capturas de pantalla preparadas
- [ ] Descripción de la app lista

## 🔗 Enlaces Útiles

- **Google Play Console**: https://play.google.com/console
- **App Store Connect**: https://appstoreconnect.apple.com
- **Documentación Completa**: Ver `DEPLOYMENT.md`

## 🆘 ¿Problemas?

Consulta `DEPLOYMENT.md` para la guía completa con solución de problemas.

