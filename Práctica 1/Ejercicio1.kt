// Creamos una función que nos permita calcular la cantidad de dinero final que recibe cada empleado. El resultado retornará un FLOAT.
// El parámetro "puntos" es de tipo INT siempre. El parámetro "salario" es de tipo FLOAT pues hay salarios con decimales.

fun cantidadDinero(salario: Float, puntos: Int): Float{
    var cantidadRecibida: Float
    cantidadRecibida = salario * (puntos/10f) // Se divide entre "10f" porque el valor retorna siempre un FLOAT, de hacerlo con "10" eL resultado de la división es 0.
    if (puntos == -1) // Condición en caso se ingrese el valor de "puntos" de forma incorrecta.
        return 0.0f
    else
        return cantidadRecibida
}

fun nivelEmpleado(puntos: Int): String{ //Retorna un STRING
    return when(puntos){ //Agregamos la palabra return pues estamos obligados a retornar un STRING. No es posible usar println() pues ello no retorna nada.
        in 0..3 -> "Nivel de rendimiento inaceptable"
        in 4..6 -> "Nivel de rendimiento aceptable"
        in 7..10 -> "Nivel de rendimiento meritorio"
        else -> "Valor no válido" // En caso los puntos no esten dentro de los rangos establecidos
    }
}

fun main (){
    println("Ingresa tu salario mensual:")
    val salarioMensual = readln().toFloat() // Input del usuario que se convierte a tipo FLOAT. La función readln() siempre retorna STRING.

    println("Ingresa tu puntuación:")
    var puntuacion = readln().toInt() // Input del usuario que se convierte a tipo INT.

    val mensajeRendimiento: String = nivelEmpleado(puntuacion) //Guardamos el resultado de la función "nivelEmpleado" en una variable.

    if (mensajeRendimiento == "Valor no válido") puntuacion = -1 // Para que tanto el mensajeRendimiento como el dinero recibido sean "Valor no Válido" y 0.0

    println("Resultado: $mensajeRendimiento, Cantidad de dinero recibida: ${cantidadDinero(salarioMensual, puntuacion)}")
}

