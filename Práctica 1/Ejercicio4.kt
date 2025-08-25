
fun main (){
    var intentos = 5 //Definimos un número invariable.
    val numeroBot = (1..30).random() //Usamos la funcion random para que la variable "numeroBot" almacene un número entre el 1 y el 30
    println("Adivina el número")

    for (i in intentos downTo 0){
        if (i == 0){
            println("Última oportunidad") //Mensaje cuando solo le quede un intento más por adivinar
        }
        var numeroUser = readln().toInt() // Transformamos el input en entero.

        if (numeroUser==numeroBot) {
            println("Ganaste, gracias por jugar") //Cuando logra adivinar el número.
            return
        }

        if (i == 0) break // Uso esta condición cuando no logra adivinar en su último intento. De este modo evito que se muestre los 2 últimos mensajes.

        println("Te doy una mano")
        if (numeroUser>numeroBot){ // Ayuda al usuario
            println("Te pasaste un poco, intenta con un número menor")
        }
        else{
            println("Te falta un poco, intenta con un número mayor")
        }
    }

     println("Lo lamento, el número era $numeroBot") //Mensaje para ver que número se le asignó a "numeroBot"
}