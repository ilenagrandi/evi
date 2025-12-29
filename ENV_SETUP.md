# 🌸 Configuración de Variables de Entorno - EVI

Este documento explica cómo configurar las variables de entorno para la aplicación EVI.

## 📋 Archivos de Configuración

- **`.env`**: Archivo con tus variables de entorno (no se sube al repositorio)
- **`.env.example`**: Plantilla de ejemplo con todas las variables disponibles

## 🚀 Inicio Rápido

1. **Copia el archivo de ejemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo `.env`** con tus valores personalizados (si es necesario)

3. **Ejecuta la app:**
   ```bash
   ./run_app.sh
   ```

¡Eso es todo! El script `run_app.sh` leerá automáticamente el archivo `.env` y pasará las variables a Flutter.

## 📝 Variables Disponibles

### `DEV`
- **Tipo**: Boolean
- **Valores**: `true` o `false`
- **Descripción**: Controla si se usan servicios mock o servicios reales de API
- **Valor por defecto**: `true`
- **Ejemplo**: `DEV=true`

### `API_BASE_URL`
- **Tipo**: String
- **Descripción**: URL base de la API del backend NestJS
- **Valor por defecto**: `http://localhost:3000`
- **Ejemplos**:
  - Desarrollo local: `http://localhost:3000`
  - Android Emulator: `http://10.0.2.2:3000`
  - iOS Simulator: `http://localhost:3000`
  - Dispositivo físico: `http://192.168.1.100:3000` (reemplaza con tu IP)
  - Producción: `https://api.evi.app`

## 🔧 Configuración por Plataforma

### Desarrollo Local (Web/Desktop)
```env
DEV=true
API_BASE_URL=http://localhost:3000
```

### Android Emulator
```env
DEV=false
API_BASE_URL=http://10.0.2.2:3000
```

### iOS Simulator
```env
DEV=false
API_BASE_URL=http://localhost:3000
```

### Dispositivo Físico
1. Encuentra la IP de tu máquina:
   ```bash
   # Linux/Mac
   ip addr show | grep "inet " | grep -v 127.0.0.1
   
   # O simplemente
   hostname -I
   ```

2. Configura el `.env`:
   ```env
   DEV=false
   API_BASE_URL=http://192.168.1.XXX:3000
   ```
   (Reemplaza `XXX` con los últimos números de tu IP)

3. Asegúrate de que tu backend esté escuchando en todas las interfaces:
   ```bash
   # En el backend NestJS
   npm run start:dev -- --host 0.0.0.0
   ```

### Producción
```env
DEV=false
API_BASE_URL=https://api.evi.app
```

## 🛠️ Ejecución Manual (sin script)

Si prefieres ejecutar Flutter manualmente, puedes pasar las variables así:

```bash
flutter run --dart-define=DEV=true --dart-define=API_BASE_URL=http://localhost:3000
```

O cargar desde el archivo `.env`:

```bash
# Cargar variables desde .env y ejecutar
source <(grep -v '^#' .env | sed 's/^/export /')
flutter run --dart-define=DEV=$DEV --dart-define=API_BASE_URL=$API_BASE_URL
```

## 📚 Variables Futuras

El archivo `.env` incluye comentarios sobre variables que se usarán en el futuro:
- `ENABLE_PUSH_NOTIFICATIONS`: Para habilitar notificaciones push
- `FCM_SERVER_KEY`: Clave del servidor Firebase Cloud Messaging
- `ENABLE_ANALYTICS`: Para habilitar analytics
- `ANALYTICS_KEY`: Clave de analytics
- `STRIPE_PUBLIC_KEY`: Clave pública de Stripe para pagos
- `STRIPE_SECRET_KEY`: Clave secreta de Stripe (solo para backend)

Estas variables están comentadas por ahora y se activarán cuando se implementen esas funcionalidades.

## ⚠️ Notas Importantes

1. **Nunca subas el archivo `.env` al repositorio**: Contiene información sensible
2. **El archivo `.env.example` sí se sube**: Es una plantilla segura
3. **Si cambias el `.env`**, reinicia la app para que los cambios surtan efecto
4. **Para producción**, usa variables de entorno del sistema o servicios de gestión de secretos

## 🐛 Solución de Problemas

### El script no encuentra el archivo .env
- Asegúrate de estar en el directorio raíz del proyecto (`evi/`)
- Verifica que el archivo se llame exactamente `.env` (con el punto al inicio)

### Las variables no se están aplicando
- Verifica que no haya espacios alrededor del `=` en el archivo `.env`
- Asegúrate de que las líneas no estén comentadas (no empiecen con `#`)
- Reinicia la app después de cambiar el `.env`

### Error de conexión al backend
- Verifica que `API_BASE_URL` sea correcta para tu plataforma
- Asegúrate de que el backend esté corriendo
- Para dispositivos físicos, verifica que estén en la misma red WiFi

