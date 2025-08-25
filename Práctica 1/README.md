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
  
### `random()`
- Se utiliza para generar datos aleatorios..  
- Muy útil dentro de la programación.  
- Ejemplo(Dentro de mí trabajo):  
  ```kotlin
  fun main (){
    var intentos = 5 
    val numeroBot = (1..30).random()
  }

## 2. Detalles de la Práctica 1
### Ejecución de archivos
1. Clonar repositorio

**Comando para clonar repositorio**
  ```bash
  git clone https://github.com/SebastianCastro-ULS/Programaci-nParaDispositivosMoviles.git

  ```
2. Abrir el proyecto con IntelliJ IDEA o un editor compatible con Kotlin.

[Descargar IntelliJ IDEA para Windows](https://www.jetbrains.com/es-es/idea/download/?section=windows#)

3. Ejecutar cada archivo.

## 3. Conclusiones

Al ser mi primera experiencia con Kotlin, me sorprende ver lo intuitivo que es. A diferencia de otros lenguajes de programación como C++ o C#, Kotlin me
parece muy atractivo y fácil de aprender.
Durante el desarrollo de la práctica puedo destacar los siguientes puntos:
- La forma en que se declaran variables me parece intuitiva y muy práctica.
- Existen algunas fanciones como `.toFloat()` y `.lowercase()` que hacen el trabajo más sencillo.
- Es importante desarrollar la lógica de programación. Si bien es cierto mis soluciones a los problemas no fueron las mejores en cuanto a recursos y tiempo, debo reconocer que me costaró hallarles una solución práctica. Sin importar el lenguaje de programación, la lógica que cada uno tiene va a ayudar a que uno pueda resolver un problema en más o menos tiempo. Este trabajo me sirvió como recordatorio que incluso las cosas más sencillas demandan tu atención y dedicación.
