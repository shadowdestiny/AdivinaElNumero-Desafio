
# Adivina el Número – Proyecto Flutter

Este es un juego interactivo desarrollado en Flutter como parte de una prueba técnica para AGNOSTIKO. El objetivo es que el usuario adivine un número secreto dentro de un rango, con retroalimentación inmediata y dificultad seleccionable.

---

## 🚀 Tecnologías usadas

- **Lenguaje:** Dart
- **Framework:** Flutter
- **Plugin de persistencia:** shared_preferences
- **Compatibilidad:** Android (probado en emuladores y dispositivos reales)

---

## 🧠 Funcionalidades

- 4 niveles de dificultad:
  - Fácil (1–10)
  - Medio (1–20)
  - Difícil (1–100)
  - Extremo (1–1000)

- Control de intentos según nivel
- Validaciones claras de entrada
- Feedback instantáneo (acierto, muy alto, muy bajo)
- Columnas separadas para:
  - 🔻 Menor que el número secreto
  - 🔺 Mayor que el número secreto
  - ✅ Historial de intentos (verde para aciertos, rojo para errores)

- Scroll automático al fondo del historial
- Scrollbar flotante pegado al borde derecho
- Botón para borrar historial

---

## 📁 Estructura

```
lib/
├── main.dart
├── pages/
│   └── adivina_page.dart
├── widgets/
│   └── column_box.dart
├── models/
│   └── difficulty_config.dart
├── services/
│   └── history_service.dart
```

---

## 🛠 Instrucciones para ejecutar

```bash
flutter pub get
flutter run
```

Para Android, asegúrate de:
- Tener el modo desarrollador activado (Windows)
- NDK actualizado a 27.x si usas shared_preferences

---

## 📦 Buenas prácticas aplicadas

- Código modular y comentado
- Reutilización de widgets (`ColumnBox`)
- Controlador de historial desacoplado
- Estilo visual coherente
- Scrolls independientes en cada panel

---

## 👨‍💻 Autor

Desarrollado por **Luis Marin**  
Proyecto entregado para evaluación técnica de AGNOSTIKO.
