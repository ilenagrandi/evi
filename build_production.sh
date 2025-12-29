#!/bin/bash

# ============================================
# Script de Build para Producción - EVI
# ============================================
# Este script construye la app para subirla a los app stores
# con la configuración de producción correcta.
# ============================================

set -e  # Salir si hay algún error

echo "🌸 EVI - Build de Producción"
echo "================================"
echo ""

# Navegar al directorio del proyecto
cd "$(dirname "$0")"

# Verificar que Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado o no está en el PATH"
    exit 1
fi

# Verificar que existe el archivo .env.production
ENV_FILE=".env.production"
if [ ! -f "$ENV_FILE" ]; then
    echo "⚠️  Archivo .env.production no encontrado"
    echo "   Creando desde .env.production.example..."
    
    if [ -f ".env.production.example" ]; then
        cp .env.production.example .env.production
        echo "✅ Archivo .env.production creado"
        echo "   ⚠️  IMPORTANTE: Edita .env.production con tus valores de producción"
        echo ""
    else
        echo "❌ No se encontró .env.production.example"
        echo "   Creando .env.production con valores por defecto..."
        
        cat > .env.production << EOF
# Configuración de Producción
DEV=false
API_BASE_URL=https://api.evi.app
EOF
        
        echo "✅ Archivo .env.production creado con valores por defecto"
        echo "   ⚠️  IMPORTANTE: Edita .env.production con tus valores reales de producción"
        echo ""
    fi
fi

# Cargar variables de entorno desde .env.production
echo "📄 Cargando configuración de producción..."
DART_DEFINES=""

while IFS= read -r line || [ -n "$line" ]; do
    if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
        key=$(echo "$line" | cut -d '=' -f 1 | xargs)
        value=$(echo "$line" | cut -d '=' -f 2- | xargs)
        
        if [ -n "$key" ] && [ -n "$value" ]; then
            DART_DEFINES="$DART_DEFINES --dart-define=$key=$value"
        fi
    fi
done < "$ENV_FILE"

echo "✅ Configuración cargada"
echo ""

# Instalar dependencias
echo "📦 Instalando dependencias..."
flutter pub get

# Limpiar builds anteriores
echo "🧹 Limpiando builds anteriores..."
flutter clean

# Obtener el comando de build
PLATFORM=${1:-both}

case $PLATFORM in
    android)
        echo ""
        echo "🤖 Construyendo APK/AAB para Android..."
        echo ""
        echo "Opciones:"
        echo "  1) APK (para testing)"
        echo "  2) AAB (para Google Play Store)"
        read -p "Selecciona una opción (1 o 2): " android_option
        
        if [ "$android_option" = "1" ]; then
            echo "📦 Construyendo APK..."
            flutter build apk --release $DART_DEFINES
            echo ""
            echo "✅ APK construido en: build/app/outputs/flutter-apk/app-release.apk"
        else
            echo "📦 Construyendo AAB..."
            flutter build appbundle --release $DART_DEFINES
            echo ""
            echo "✅ AAB construido en: build/app/outputs/bundle/release/app-release.aab"
            echo ""
            echo "📤 Para subir a Google Play Store:"
            echo "   https://play.google.com/console"
        fi
        ;;
    ios)
        echo ""
        echo "🍎 Construyendo para iOS..."
        echo ""
        echo "⚠️  Asegúrate de tener:"
        echo "   - Xcode instalado"
        echo "   - Certificados de desarrollo/configuración configurados"
        echo "   - Un dispositivo iOS o simulador conectado"
        echo ""
        read -p "¿Continuar? (s/n): " continue_ios
        
        if [ "$continue_ios" = "s" ]; then
            flutter build ios --release $DART_DEFINES
            echo ""
            echo "✅ Build de iOS completado"
            echo ""
            echo "📤 Para subir a App Store:"
            echo "   1. Abre Xcode"
            echo "   2. Abre ios/Runner.xcworkspace"
            echo "   3. Product > Archive"
            echo "   4. Distribute App"
        fi
        ;;
    both)
        echo ""
        echo "🚀 Construyendo para ambas plataformas..."
        echo ""
        echo "🤖 Android..."
        flutter build appbundle --release $DART_DEFINES
        echo ""
        echo "🍎 iOS..."
        flutter build ios --release $DART_DEFINES
        echo ""
        echo "✅ Builds completados para ambas plataformas"
        ;;
    *)
        echo "❌ Plataforma no válida: $PLATFORM"
        echo "   Uso: ./build_production.sh [android|ios|both]"
        exit 1
        ;;
esac

echo ""
echo "✅ Build de producción completado"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Verifica que la configuración en .env.production sea correcta"
echo "   2. Prueba la app en un dispositivo real antes de subir"
echo "   3. Revisa los logs y asegúrate de que todo funcione"
echo ""

