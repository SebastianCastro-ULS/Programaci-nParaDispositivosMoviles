/*
Ejercicio 1
La clase CuentaBancaria gestiona saldo, límite de retiro y permite realizar retiros válidos.
Autor: Sebastian Castro
Fecha: 09/09/2025
*/

// Para los parámetros usamos datos de tipo Double.
class CuentaBancaria(private var saldo: Double, private var limiteRetiro: Double) {

    // Getter para obtener el saldo
    fun getSaldo(): Double = saldo

    // Setter para validar
    fun setSaldo(nuevoSaldo: Double) {
        if (nuevoSaldo >= 0) {
            this.saldo = nuevoSaldo
        } else {
            println("El saldo no puede ser negativo")
        }
    }

    // Función para retirar un monto validando el límite
    fun retirar(monto: Double) {
        when { // Usamos when para las diferentes situaciones que pueden suceder al retirar un monto
            monto > saldo -> println("Tus fondos son insuficientes")
            monto > limiteRetiro -> println("El monto supera el límite de retiro")
            monto <= 0 -> println("El monto debe ser mayor a 0")
            else -> {
                saldo -= monto // Restamos el monto del saldo total
                println("Retiraste $monto. Saldo actual: $saldo")
            }
        }
    }
}

// Aplicamos la clase CuentaBancaria
fun main() {
    val cuenta = CuentaBancaria(5000.0, 5000.0)

    cuenta.retirar(600.0)
    cuenta.retirar(200.0)

    cuenta.setSaldo(-200.0)
    println(cuenta.getSaldo())
}
