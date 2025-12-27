# 🚀 Cómo Ver el Frontend de EVI

## Opción 1: Si ya tienes Flutter instalado

### Pasos rápidos:

```bash
cd /home/alina/Desktop/evi_project/evi
flutter pub get
flutter run -d chrome
```

Esto abrirá la app en Chrome automáticamente.

### O usar el script:

```bash
./run_app.sh
```

---

## Opción 2: Si NO tienes Flutter instalado

### Instalación rápida en Linux:

#### Método 1: Usando Snap (más fácil)

```bash
sudo snap install flutter --classic
flutter doctor
```

#### Método 2: Instalación manual

1. **Descargar Flutter:**
   ```bash
   cd ~
   git clone https://github.com/flutter/flutter.git -b stable
   ```

2. **Agregar Flutter al PATH:**
   Edita tu `~/.zshrc` (o `~/.bashrc` si usas bash):
   ```bash
   nano ~/.zshrc
   ```
   
   Agrega al final:
   ```bash
   export PATH="$PATH:$HOME/flutter/bin"
   ```

3. **Recargar la configuración:**
   ```bash
   source ~/.zshrc
   ```

4. **Verificar instalación:**
   ```bash
   flutter doctor
   ```

5. **Instalar dependencias necesarias:**
   ```bash
   flutter doctor --android-licenses  # Si quieres Android
   ```

### Después de instalar Flutter:

```bash
cd /home/alina/Desktop/evi_project/evi
flutter pub get
flutter run -d chrome
```

---

## Opción 3: Usar Flutter Web directamente

Si solo quieres ver el frontend sin instalar todo Flutter, puedes:

1. **Instalar solo Flutter SDK:**
   ```bash
   sudo snap install flutter --classic
   ```

2. **Habilitar web:**
   ```bash
   flutter config --enable-web
   ```

3. **Ejecutar:**
   ```bash
   cd /home/alina/Desktop/evi_project/evi
   flutter pub get
   flutter run -d chrome
   ```

---

## 🐛 Solución de Problemas

### Error: "Flutter no encontrado"
- Asegúrate de que Flutter esté en tu PATH
- Ejecuta `echo $PATH` para verificar
- Reinicia la terminal después de agregar Flutter al PATH

### Error: "No devices found"
- Para web: `flutter config --enable-web`
- Para Android: Instala Android Studio y un emulador
- Para Linux desktop: `flutter config --enable-linux-desktop`

### Error al ejecutar `flutter pub get`
- Verifica tu conexión a internet
- Asegúrate de estar en el directorio correcto
- Verifica que `pubspec.yaml` esté correcto

---

## 📱 Dispositivos Disponibles

Para ver qué dispositivos tienes disponibles:

```bash
flutter devices
```

Opciones comunes:
- **Chrome**: `flutter run -d chrome` (más fácil para desarrollo)
- **Linux**: `flutter run -d linux` (si tienes Linux desktop habilitado)
- **Android**: `flutter run -d <device-id>` (si tienes un emulador o dispositivo)

---

## 🎨 Ver la App

Una vez que ejecutes `flutter run`, deberías ver:

1. **Onboarding** (3 pantallas con emojis y explicaciones)
2. **Home** (con información del ciclo y recomendaciones)
3. **Navegación** entre todas las pantallas

La app está completamente funcional con datos mock, así que puedes navegar y ver todas las pantallas sin necesidad de backend.

---

## 💡 Tips

- Presiona `r` en la terminal mientras la app corre para hacer hot reload
- Presiona `R` para hacer hot restart
- Presiona `q` para salir
- Usa Chrome DevTools para inspeccionar elementos (F12)

---

## ¿Necesitas ayuda?

Si encuentras algún problema, verifica:
1. `flutter doctor` - muestra el estado de tu instalación
2. `flutter --version` - verifica la versión
3. Revisa los logs en la terminal para ver errores específicos

