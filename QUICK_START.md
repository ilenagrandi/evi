# ⚡ Inicio Rápido - Ver EVI

## 🎯 Pasos Rápidos (3 comandos)

```bash
# 1. Ir al directorio del proyecto
cd /home/alina/Desktop/evi_project/evi

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar en Chrome (más fácil)
flutter run -d chrome
```

---

## 📋 Si no tienes Flutter instalado:

### Instalación rápida (1 comando):

```bash
sudo snap install flutter --classic
```

Luego ejecuta los 3 comandos de arriba.

---

## 🎨 ¿Qué deberías ver?

### 1. **Pantalla de Onboarding** (al iniciar)
   - 🌸 "Bienvenida a EVI"
   - 🌙 "Ciclo + Ayuno Intermitente"  
   - 💝 "Tu bienestar, nuestra prioridad"
   - Botón "Comenzar" al final

### 2. **Pantalla Home** (después de "Comenzar")
   - Card con día del ciclo y fase actual
   - Card con recomendación de ayuno (ej: "14 horas")
   - Accesos rápidos a "Registrar síntomas" y "Mi ayuno"

### 3. **Navegación**
   - Botón de perfil (arriba derecha)
   - Cards clicables para ir a otras pantallas

### 4. **Pantalla de Síntomas**
   - Chips seleccionables (😴 Cansancio, 😣 Dolor, etc.)
   - Campo de texto para notas
   - Botón "Guardar"

### 5. **Pantalla de Ayuno**
   - Recomendación grande (ej: "16 horas")
   - Descripción de por qué esa recomendación
   - Historial de últimos 7 días

### 6. **Pantalla de Perfil**
   - Información del usuario
   - Plan actual (Gratuito)
   - Toggle de notificaciones
   - Opciones adicionales

---

## 🚨 Si algo no funciona:

1. **Verifica Flutter:**
   ```bash
   flutter doctor
   ```

2. **Habilita web (si es necesario):**
   ```bash
   flutter config --enable-web
   ```

3. **Verifica dispositivos:**
   ```bash
   flutter devices
   ```

4. **Limpia y reinstala:**
   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

---

## 💻 Alternativa: Usar el script

```bash
./run_app.sh
```

El script verifica todo automáticamente y te guía si falta algo.

