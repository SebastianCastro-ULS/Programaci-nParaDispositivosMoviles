/*
Ejercicio 2
La clase Producto calcula el precio del producto tras un descuento.
*/

class Producto(private var precio: Double, private var descuento: Double) {

    // Getters del precio y del descuento
    fun getPrecio(): Double = precio
    fun getDescuento(): Double = descuento

    // Setters con validaciones
    fun setPrecio(nuevoPrecio: Double) {
        if (nuevoPrecio > 0) {
            this.precio = nuevoPrecio
        }
        else println("El precio debe ser mayor que 0")
    }

    fun setDescuento(nuevoDescuento: Double) {
        if (nuevoDescuento in 0.0..100.0) {
            this.descuento = nuevoDescuento
        }
        else println("Descuento no válido")
    }

    // Calculamos el precio final
    fun precioFinal(): Double {
        return precio - (precio * descuento / 100)
    }
}

// Aplicamos la clase Producto
fun main() {
    val producto = Producto(200.0, 10.0)
    println("Precio final: ${producto.precioFinal()}")

    producto.setDescuento(-1.0)
    producto.setPrecio(-1.0)
    println(producto.getDescuento())
}