# Práctica 1: Introducción a Kotlin

**Estudiante:** Sebastian Castro 
**Curso:** Programación para Dispositivos Móviles  
**Docente:** Josue Miguel Flores Parra  

## 1. Comandos a investigar en Kotlin

### `readln()`
- Permite **leer datos ingresados por el usuario** desde la consola.  
- Retorna el valor como `String`.  
- Ejemplo:  
  ```kotlin
  fun main() {
      println("Ingrese su nombre:")
      val nombre = readln()
      println("Hola, $nombre!")
  }
