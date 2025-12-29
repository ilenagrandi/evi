#!/bin/bash

# Script para ejecutar la app EVI
# Este script verifica Flutter, lee el archivo .env y ejecuta la app

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

# Cargar variables de entorno desde .env
ENV_FILE=".env"
DART_DEFINES=""

if [ -f "$ENV_FILE" ]; then
    echo "📄 Leyendo configuración desde .env..."
    
    # Leer el archivo .env línea por línea
    while IFS= read -r line || [ -n "$line" ]; do
        # Ignorar líneas vacías y comentarios
        if [[ -n "$line" && ! "$line" =~ ^[[:space:]]*# ]]; then
            # Extraer clave y valor (soporta espacios alrededor del =)
            key=$(echo "$line" | cut -d '=' -f 1 | xargs)
            value=$(echo "$line" | cut -d '=' -f 2- | xargs)
            
            # Solo procesar si hay una clave válida
            if [ -n "$key" ] && [ -n "$value" ]; then
                # Agregar a DART_DEFINES
                DART_DEFINES="$DART_DEFINES --dart-define=$key=$value"
            fi
        fi
    done < "$ENV_FILE"
    
    echo "✅ Configuración cargada"
    echo ""
else
    echo "⚠️  Archivo .env no encontrado. Usando valores por defecto."
    echo "   Crea un archivo .env basado en .env.example si necesitas configuración personalizada."
    echo ""
fi

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

# Ejecutar la app con las variables de entorno
# Si hay un dispositivo web, usarlo; si no, usar el primer dispositivo disponible
if flutter devices | grep -q "Chrome"; then
    echo "🌐 Ejecutando en Chrome..."
    flutter run -d chrome $DART_DEFINES
else
    echo "📱 Ejecutando en el primer dispositivo disponible..."
    flutter run $DART_DEFINES
fi


