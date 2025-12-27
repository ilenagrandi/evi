#!/bin/bash

# Script para ejecutar la app EVI
# Este script verifica Flutter y ejecuta la app

echo "🌸 EVI - Verificando entorno..."

# Verificar si Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado o no está en el PATH"
    echo ""
    echo "📦 Para instalar Flutter:"
    echo "   1. Visita: https://docs.flutter.dev/get-started/install/linux"
    echo "   2. O usa snap: sudo snap install flutter --classic"
    echo "   3. Ejecuta: flutter doctor"
    echo ""
    echo "🌐 Alternativa: Si tienes Flutter instalado pero no en PATH,"
    echo "   agrega la ruta de Flutter a tu ~/.zshrc o ~/.bashrc"
    exit 1
fi

echo "✅ Flutter encontrado"
echo ""

# Verificar versión
echo "📱 Versión de Flutter:"
flutter --version | head -2
echo ""

# Navegar al directorio del proyecto
cd "$(dirname "$0")"

# Instalar dependencias
echo "📦 Instalando dependencias..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Error al instalar dependencias"
    exit 1
fi

echo ""
echo "✅ Dependencias instaladas"
echo ""

# Verificar dispositivos disponibles
echo "🔍 Buscando dispositivos disponibles..."
flutter devices

echo ""
echo "🚀 Iniciando la app EVI..."
echo "   (Presiona 'q' para salir)"
echo ""

# Ejecutar la app
# Si hay un dispositivo web, usarlo; si no, usar el primer dispositivo disponible
if flutter devices | grep -q "Chrome"; then
    echo "🌐 Ejecutando en Chrome..."
    flutter run -d chrome
else
    echo "📱 Ejecutando en el primer dispositivo disponible..."
    flutter run
fi

