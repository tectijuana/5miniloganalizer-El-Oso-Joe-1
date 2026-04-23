# Practica 4.2 — Mini Cloud Log Analyzer en ARM64

**Curso:** Lenguajes de Interfaz  
**Modalidad:** Individual  
**Nombre:** Andres Manuel Perez Flores
**Entorno:** AWS Ubuntu ARM64 + GitHub Classroom  
**Lenguaje:** ARM64 Assembly (GNU Assembler) + Bash + GNU Make

---

## Introduccion

Los sistemas modernos de computo en la nube generan continuamente registros (logs) que permiten monitorear el estado de servicios, detectar fallas y activar alertas ante eventos criticos.

En esta practica se desarrolla un modulo simplificado de analisis de logs implementado en ARM64 Assembly, inspirado en tareas reales de monitoreo utilizadas en sistemas cloud, observabilidad y administracion de infraestructura.

El programa procesa codigos de estado HTTP suministrados mediante entrada estandar (`stdin`):

```bash
cat logs.txt | ./analyzer
```

---

## Objetivo General

Disenar e implementar, en lenguaje ensamblador ARM64, una solucion para procesar registros de eventos y detectar condiciones definidas segun la variante asignada.

---

## Objetivos Especificos

El estudiante aplicara los siguientes conceptos:

- Programacion en ARM64 bajo Linux
- Manejo de registros
- Direccionamiento y acceso a memoria
- Instrucciones de comparacion
- Estructuras iterativas en ensamblador
- Saltos condicionales
- Uso de syscalls Linux
- Compilacion con GNU Make
- Control de versiones con GitHub Classroom

Estos temas se alinean con contenidos clasicos de flujo de control, herramientas GNU, manejo de datos y convenciones de programacion en ensamblador.

---

## Material Proporcionado

El repositorio preconfigurado contiene:

| Archivo / Elemento | Descripcion |
|---|---|
| `src/analyzer.s` | Plantilla base en ARM64 con secciones `TODO` |
| `Makefile` | Configuracion de compilacion con GNU Make |
| `run.sh` | Script Bash de ejecucion |
| `data/logs_*.txt` | Archivos de datos de prueba |
| `tests/` | Pruebas iniciales y salidas esperadas |

---

## Variantes de la Practica

| Variante | Descripcion |
|---|---|
| **A** | Contabilizar respuestas exitosas (2xx), errores del cliente (4xx) y errores del servidor (5xx) |
| **B** | Determinar el codigo de estado mas frecuente |
| **C** | Detectar el primer evento critico (503) |
| **D** | Detectar tres errores consecutivos |
| **E** | Calcular indice de salud: `Health Score = 100 - (errores x 10)` |

---

## Compilacion y Ejecucion

**Compilar:**

```bash
make
```

**Ejecutar:**

```bash
cat logs.txt | ./analyzer
```

---

## Entregables

Cada estudiante debera incluir en su repositorio:

- Archivo fuente ARM64 funcional (`src/analyzer.s` completado)
- Solucion implementada segun la variante asignada
- `README.md` explicando el diseno y la logica utilizada
- Evidencia de ejecucion (capturas o salida en texto)
- Historial de commits realizados en GitHub Classroom

---

## Criterios de Evaluacion

| Criterio | Ponderacion |
|---|---|
| Compilacion correcta | 20% |
| Correctitud de la solucion | 35% |
| Uso adecuado de ARM64 | 25% |
| Documentacion y comentarios | 10% |
| Evidencia de pruebas | 10% |

---

## Restricciones

No esta permitido:

- Resolver la logica en C
- Resolver la logica en Python
- Modificar la variante asignada
- Omitir el uso de ARM64 Assembly

---

LINK DEL ASCIINEMA: https://asciinema.org/a/4aHlbiyZDaxoG6Yo
