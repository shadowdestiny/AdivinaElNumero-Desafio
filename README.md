
# Adivina el Número – Flutter Challenge

Este es un proyecto realizado como parte de una prueba técnica para la empresa AGNOSTIKO. Se trata de un juego interactivo donde el usuario debe adivinar un número secreto dentro de un rango determinado, ajustado por niveles de dificultad.

## 🚀 Tecnologías usadas

- **Lenguaje:** Dart
- **Framework:** Flutter
- **Arquitectura:** Modular simple con separación por responsabilidades (`pages/`, `widgets/`, `models/`)
- **Compatibilidad:** Android, Web, Windows (opcional)

## 🧠 Funcionalidades del juego

- Cuatro niveles de dificultad:
    - Fácil: 1–10 (5 intentos)
    - Medio: 1–20 (8 intentos)
    - Difícil: 1–100 (15 intentos)
    - Extremo: 1–1000 (25 intentos)
- Validación de entradas
- Historial de intentos con colores:
    - Verde: acierto
    - Rojo: error
- Visualización de:
    - Números "mayores que" el secreto
    - Números "menores que" el secreto
- Reinicio automático al cambiar de dificultad
- UI limpia, responsiva y scrollable

## 📁 Estructura del proyecto

```
lib/
├── main.dart                    # Punto de entrada limpio
├── pages/
│   └── adivina_page.dart        # Lógica principal y vista del juego
├── widgets/
│   └── column_box.dart          # Widget reutilizable para columnas scrollables
└── models/
    └── difficulty_config.dart   # Configuración de niveles de dificultad
```

## 🛠️ Cómo ejecutar

1. Clona el repositorio:
```bash
git clone https://github.com/{todavia no lo he definido :)}/adivina-numero.git
cd adivina-numero
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Corre el proyecto:
```bash
flutter run
```

Puedes correrlo en Android, web o escritorio.

## 📦 Buenas prácticas aplicadas

- Separación de responsabilidades (principio SOLID)
- Código documentado y legible
- Componentización de widgets
- Validaciones amigables y claras
- Comentarios para facilitar comprensión

## 🔚 Entrega

El repositorio fue organizado para facilitar la revisión del código, incluyendo estructura modular, commit limpios, y compatibilidad multiplataforma.

---
_Desarrollado por Luis Marin para AGNOSTIKO_
