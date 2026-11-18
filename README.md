# FinGuard – Acceptance Tests

Pruebas de aceptación en Gherkin del proyecto FinGuard (curso 1ASI0786 Ingeniería de Requisitos, ciclo 202620).

| Archivo | Pruebas | User Stories |
|---|---|---|
| `features/ep01_captura_automatica.feature` | AT-01 a AT-08 | US01 a US04 (EP01) |
| `features/ep03_gasto_hormiga.feature` | AT-09 a AT-14 | US08 a US11 (EP03) |
| `features/no_funcionales.feature` | AT-15 a AT-20 | US33 a US36 (EP10) |

## Convención de etiquetas

Cada escenario lleva etiquetas que permiten filtrarlo al ejecutar las pruebas:

| Etiqueta | Significado | Ejemplo |
|---|---|---|
| `@EPxx` | Épica a la que pertenece la característica | `@EP01` |
| `@AT-xx` | Identificador de la prueba de aceptación | `@AT-09` |
| `@USxx` | User Story que valida el escenario | `@US08` |
| `@funcional` / `@no-funcional` | Tipo de requisito | `@no-funcional` |
| `@rendimiento`, `@seguridad`, `@privacidad`, `@precisión`, `@usabilidad` | Atributo de calidad (solo no funcionales) | `@seguridad` |

Ejemplo de filtrado con Cucumber:

```bash
npx cucumber-js --tags "@EP03 and @funcional"
```
