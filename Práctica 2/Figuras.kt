/*
Ejercicio 3
La clase abstracta Shape otorga propiedades a subclases para calcular área y perímetro.
 */

abstract class Shape {
    abstract fun calcularArea(): Double
    abstract fun calcularPerimetro(): Double

    fun resultados() {
        println("Área: ${calcularArea()}, Perímetro: ${calcularPerimetro()}")
    }
}

// Subclase Cuadrado
class Cuadrado(private val lado: Double) : Shape() {
    init { // Validación para ver si el lado es positivo
        require(lado > 0) { "El lado del cuadrado debe ser positivo." }
    }
    override fun calcularArea(): Double = lado * lado
    override fun calcularPerimetro(): Double = 4 * lado
}

// Subclase Rectángulo
class Rectangulo(private val base: Double, private val altura: Double) : Shape() {
    init { // Validación
        require(base > 0 && altura > 0) { "Los lados del rectángulo deben ser positivos." }
    }
    override fun calcularArea(): Double = base * altura
    override fun calcularPerimetro(): Double = 2 * (base + altura)
}

// Subclase Círculo
class Circulo(private val radio: Double) : Shape() {
    init { // Validación
        require(radio > 0) { "El radio del círculo debe ser positivo." }
    }
    override fun calcularArea(): Double = 3.14 * radio * radio
    override fun calcularPerimetro(): Double = 2 * 3.14 * radio
}

// Aplicamos las subclases
fun main() {
    val cuadrado = Cuadrado(5.0)
    val rectangulo = Rectangulo(-4.0, 6.0)
    val circulo = Circulo(5.0)

    cuadrado.resultados()
    rectangulo.resultados()
    circulo.resultados()
}