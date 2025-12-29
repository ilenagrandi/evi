# 🔐 Configuración de Keystore para Android - EVI

Esta guía explica cómo configurar el keystore para firmar la aplicación Android antes de subirla a Google Play Store.

## 📋 Pasos

### 1. Crear el Keystore

```bash
keytool -genkey -v -keystore ~/evi-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias evi
```

**Información que te pedirá:**
- Contraseña del keystore (guárdala de forma segura)
- Contraseña de la clave (puede ser la misma)
- Nombre y apellidos
- Unidad organizativa
- Organización
- Ciudad
- Estado/Provincia
- Código de país (ej: ES, MX, AR)

**⚠️ IMPORTANTE**: Guarda estas contraseñas de forma segura. Si las pierdes, no podrás actualizar la app en Google Play Store.

### 2. Crear el archivo key.properties

```bash
cd android
cp key.properties.example key.properties
```

Edita `android/key.properties` con tus valores:

```properties
storePassword=tu_contraseña_del_keystore
keyPassword=tu_contraseña_de_la_key
keyAlias=evi
storeFile=/home/tu_usuario/evi-keystore.jks
```

**⚠️ IMPORTANTE**: Usa una ruta absoluta para `storeFile`.

### 3. Actualizar build.gradle.kts

Abre `android/app/build.gradle.kts` y agrega esta configuración:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Cargar propiedades del keystore
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = java.util.Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.evi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.evi"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
```

### 4. Verificar la Configuración

```bash
# Construir un APK de release para verificar
flutter build apk --release
```

Si todo está correcto, el APK se firmará automáticamente con tu keystore.

## 🔒 Seguridad

- **NUNCA** subas `key.properties` al repositorio
- **NUNCA** subas el archivo `.jks` al repositorio
- Guarda una copia de seguridad del keystore en un lugar seguro
- Considera usar un servicio de gestión de secretos para CI/CD

## 📝 Backup del Keystore

```bash
# Crear una copia de seguridad
cp ~/evi-keystore.jks ~/evi-keystore.jks.backup

# Guarda también:
# - Las contraseñas
# - El alias usado
# - La información que ingresaste al crear el keystore
```

## 🆘 Solución de Problemas

### Error: "key.properties not found"
- Asegúrate de que el archivo existe en `android/key.properties`
- Verifica que la ruta sea correcta

### Error: "keystore file not found"
- Verifica que la ruta en `key.properties` sea absoluta
- Asegúrate de que el archivo `.jks` existe en esa ubicación

### Error: "Wrong password"
- Verifica que las contraseñas en `key.properties` sean correctas
- Asegúrate de que no haya espacios extra

