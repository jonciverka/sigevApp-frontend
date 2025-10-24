# Sigev App

**Sigev App** es una plataforma multi-dispositivo (iOS, Android) donde permite vender cotizaciones a publico externo de la empresa.

---
## Instalación y ejecución

    Instalar dependencias:
        flutter pub get

    Ejecutar:
        flutter run


## Plataformas 

Plataformas soportadas
- **iOS**
- **Android**

## Versiones minimas 

- Flutter version 3.32.6
- Dart version 3.8.1
- Android SDK version 36.0.0


## Arquitectura 
La aplicación está estructurada en **3 capas**, utilizando **Bloc** (con *Cubits*) como manejador de estado:

1. **Presentación**
   - **Widgets**: pantallas y componentes visuales.
   - **Cubits**: coordinan la lógica de UI y llaman a repositorios.

2. **Datos / Dominio**
   - **Repositorios**: implementan la lógica de obtención de datos y deciden la fuente (remota, local).
   - **Data Sources**: acceso directo a API.

3. **Modelos**
   - Usados para mapear entre el formato externo (API/DB) y el interno (entidades de la UI).

### Diagrama de flujo de datos
    UI (Widgets)  
        ↓  
    Cubit  
        ↓  
    Repository  
        ↓  
    Data Source (Remote / Local)  
        ↓  
    Model (DTO → Entity)  
        ↑  
    Repository  
        ↑  
    Cubit (emite estado)  
        ↑  
    UI (se actualiza)

## Carpetas

Las carpetas están acomodadas de la siguiente manera:

    lib/
    ├── core/                     # Utilidades compartidas 
    │   ├── services/
    │   ├── utilities/
    ├── config/
    │   ├── colors/
    │   ├── errors
    │   ├── theme/
    │   ├── assets.dart
    │   ├── dependendy_injections.dart
    │   ├── get_rutas.dart
    │   ├── globals.dart
    │   ├── shared_preferences.dart
    │   └── strings.dart
    ├── domain
    │   ├── models/
    │   ├── providers/
    │   └── repositories/
    ├── presentation
    │   ├── globals/ 
    │   ├── pages/
    │   └── widgets/
    └── main.dart




## Módulos

    ├── Login 
   
    