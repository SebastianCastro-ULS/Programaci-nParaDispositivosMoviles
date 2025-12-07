# ♻️ Ecomun - Sistema de Gestión de Reciclaje

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

**Una aplicación móvil para facilitar el reciclaje y la gestión de residuos en tu comunidad**

</div>

---

## Descripción

**Ecomun** es una aplicación móvil desarrollada con Flutter que conecta a usuarios con servicios de recolección de materiales reciclables. La plataforma permite a los usuarios registrar solicitudes de recojo, aprender sobre materiales reciclables y hacer seguimiento de su impacto ambiental.

### Objetivo

Promover prácticas de reciclaje sostenibles facilitando la gestión y recolección de materiales reciclables en comunidades urbanas, contribuyendo a la reducción de residuos y al cuidado del medio ambiente.

### Características Principales

- **Autenticación de Usuarios**: Registro e inicio de sesión seguro con Firebase Authentication
- **Gestión de Solicitudes**: Crea y gestiona solicitudes de recojo de materiales reciclables
- **Catálogo de Materiales**: Información detallada sobre tipos de materiales reciclables y consejos
- **Estadísticas Personales**: Visualiza tu impacto ambiental y cantidad reciclada
- **Actualizaciones en Tiempo Real**: Sincronización automática con Firebase Firestore
- **Diseño Responsivo**: Interfaz moderna y adaptable a diferentes dispositivos

---

## Instalación

### Prerrequisitos

Antes de comenzar, debes de tener instalado:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.9.2 o superior)
- [Dart SDK](https://dart.dev/get-dart) (incluido con Flutter)
- [Android Studio](https://developer.android.com/studio) o [Visual Studio Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)
- Una cuenta de [Firebase](https://console.firebase.google.com/)

### Paso 1: Clonar el Repositorio

```bash
git clone https://github.com/tu-usuario/ecomun.git
cd ecomun/ecomun
```

### Paso 2: Instalar Dependencias

```bash
flutter pub get
```

### Paso 3: Configurar Firebase

#### 3.1 Crear Proyecto Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Clic en **"Agregar proyecto"**
3. Nombre del proyecto: `Ecomun`
4. Sigue los pasos y crea el proyecto

#### 3.2 Configurar Firebase en la App

**Opción A: Usar FlutterFire CLI (Recomendado)**

```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar Firebase
flutterfire configure
```

Selecciona tu proyecto `Ecomun` y las plataformas que desees (Android/iOS).

**Opción B: Manual**

Si ya tienes el archivo `firebase_options.dart`, asegúrate de que contenga tus credenciales correctas.

#### 3.3 Habilitar Servicios Firebase

**Authentication:**
1. Firebase Console → **Authentication** → **Get Started**
2. Pestaña **"Sign-in method"**
3. Habilita **"Email/Password"**
4. Guarda

**Firestore Database:**
1. Firebase Console → **Firestore Database** → **Create database**
2. Selecciona **"Start in test mode"**
3. Elige tu región preferida
4. Clic en **"Enable"**

#### 3.4 Configurar Reglas de Seguridad

En **Firestore Database** → **Rules**, pega el siguiente código:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Reglas para usuarios
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Reglas para materiales
    match /materials/{materialId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    // Reglas para solicitudes
    match /requests/{requestId} {
      allow read: if request.auth != null && 
                     resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && 
                       request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && 
                               resource.data.userId == request.auth.uid;
    }
  }
}
```

Clic en **"Publish"**

---

## Ejecución

### Ejecutar en Modo Debug

```bash
flutter run
```
</div>
