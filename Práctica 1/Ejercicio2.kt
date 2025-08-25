fun main (){
    val jugadas = listOf("PIEDRA", "PAPEL", "TIJERA") //Creamos una lista de las posibles jugadas.
    val jugadaBot = jugadas.random() // Se le asigna una elemento de la lista "jugadas" a la variable "jugadaBot".

    println("Ingrese una jugada: PIEDRA, PAPEL O TIJERA")
    val jugadaUser = readln().uppercase() // Usamos ".uppercase" para que el input del usuario siempre sea en mayúsculas.

    require (jugadaUser in jugadas) {"No se ingreso ninguna de las opciones válidas"}
    //Para validar solamente elementos dentro de la lista "jugadas". De no validarse, el programa lanza un LazyMessage indicando el motivo del error.

    //Comparamos diferentes situaciones que se dan en el juego.
    when{
        jugadaUser == jugadaBot -> println("Empate")
        jugadaUser == "PIEDRA" && jugadaBot == "TIJERA" -> println("Ganaste")
        jugadaUser == "PAPEL" && jugadaBot == "PIEDRA" -> println("Ganaste")
        jugadaUser == "TIJERA" && jugadaBot == "PAPEL" -> println("Ganaste")
        else -> println("Perdiste")
    }

    println("El bot jugó $jugadaBot") //Verificamos que el elemento aleatorio asignado a "jugadaBOt" cumpla con las situaciones dentro de la estructura de control WHEN
}