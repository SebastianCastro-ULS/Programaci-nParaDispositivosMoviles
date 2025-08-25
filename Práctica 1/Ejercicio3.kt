fun main (){
    var primerValor: Float
    var segundoValor: Float
    var respuesta: Float

    println("Hola, esta es mi calculadora...")
    while(true) { //Usamos un WHILE pues queremos que la calculadora unicamente termine cuando el usuario ponga "salir".
        println("==== Menú ====")
        println("   1. Suma  " )
        println("   2. Resta  " )
        println("   3. Multiplicacion  " )
        println("   4. Division  " )
        println("   5. Salir  " )

        var opcionUser = readln().lowercase() // Le damos la opcion al usuario de escribir que operación desea realizar, ponemos "lowercase" para estandarizar.
        when (opcionUser) {
            "1", "suma" -> {
                println("Ingresa 2 números") //Unicamente tomamos 2 valores.
                primerValor = readln().toFloat()
                segundoValor = readln().toFloat()
                respuesta = primerValor + segundoValor
                println("Respuesta: $respuesta")
            }
            "2", "resta" -> {
                println("Ingresa 2 números")
                primerValor = readln().toFloat()
                segundoValor = readln().toFloat()
                respuesta = primerValor - segundoValor
                println("Respuesta: $respuesta")

            }
            "3", "multiplicacion" -> {
                println("Ingresa 2 números")
                primerValor = readln().toFloat()
                segundoValor = readln().toFloat()
                respuesta = primerValor * segundoValor
                println("Respuesta: $respuesta")
            }
            "4", "division" -> {
                println("Ingresa 2 números")
                primerValor = readln().toFloat()
                segundoValor = readln().toFloat()
                respuesta = primerValor / segundoValor
                println("Respuesta: $respuesta")
            }
            "5", "salir" -> {
                println("Gracias por usarla...")
                return //El programa se detiene.
            }
            else -> println("Intenta de nuevo") // Si se ingresa un número o palabra que no esta en la lista, el programa muestra este mensaje y vuelve a poner el MENÚ
        }
    }
}