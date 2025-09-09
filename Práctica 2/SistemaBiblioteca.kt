/*
Ejercicio 3
Sistema de gestión de una biblioteca
*/

// Clase abstracta Material
abstract class Material(
    val titulo: String,
    val autor: String,
    val añoPublicacion: Int
) {
    abstract fun mostrarDetalles()
}

// Subclase Libro
class Libro(
    titulo: String,
    autor: String,
    añoPublicacion: Int,
    val genero: String,
    val numPaginas: Int
) : Material(titulo, autor, añoPublicacion) {
    override fun mostrarDetalles() {
        println("Libro: $titulo, Autor: $autor, Año: $añoPublicacion, Género: $genero, Páginas: $numPaginas")
    }
}

// Subclase Revista
class Revista(
    titulo: String,
    autor: String,
    añoPublicacion: Int,
    val issn: String,
    val volumen: Int,
    val numero: Int,
    val editorial: String
) : Material(titulo, autor, añoPublicacion) {
    override fun mostrarDetalles() {
        println("Revista: $titulo, Autor: $autor, Año: $añoPublicacion, ISSN: $issn, Volumen: $volumen, Número: $numero, Editorial: $editorial")
    }
}

// Data class Usuario
data class Usuario(val nombre: String, val apellido: String, val edad: Int)

// Interfaz IBiblioteca
interface IBiblioteca {
    fun registrarMaterial(material: Material)
    fun registrarUsuario(usuario: Usuario)
    fun prestar(usuario: Usuario, material: Material)
    fun devolver(usuario: Usuario, material: Material)
    fun mostrarMaterialesDisponibles()
    fun mostrarMaterialesUsuario(usuario: Usuario)
}

// Clase Biblioteca que implementa la interfaz
class Biblioteca : IBiblioteca {
    private val materialesDisponibles = mutableListOf<Material>()
    private val prestamos = mutableMapOf<Usuario, MutableList<Material>>()

    override fun registrarMaterial(material: Material) {
        materialesDisponibles.add(material)
        println("Material '${material.titulo}' registrado con éxito.")
    }

    override fun registrarUsuario(usuario: Usuario) {
        if (!prestamos.containsKey(usuario)) {
            prestamos[usuario] = mutableListOf()
            println("Usuario '${usuario.nombre} ${usuario.apellido}' registrado con éxito.")
        } else {
            println("Error: El usuario '${usuario.nombre} ${usuario.apellido}' ya está registrado.")
        }
    }

    override fun prestar(usuario: Usuario, material: Material) {
        if (materialesDisponibles.contains(material)) {
            materialesDisponibles.remove(material)
            prestamos[usuario]?.add(material)
            println("${usuario.nombre} ha prestado: ${material.titulo}")
        } else {
            println("El material no está disponible.")
        }
    }

    override fun devolver(usuario: Usuario, material: Material) {
        if (prestamos[usuario]?.contains(material) == true) {
            prestamos[usuario]?.remove(material)
            materialesDisponibles.add(material)
            println("${usuario.nombre} ha devuelto: ${material.titulo}")
        } else {
            println("El usuario no tiene este material.")
        }
    }

    override fun mostrarMaterialesDisponibles() {
        println("Materiales disponibles:")
        materialesDisponibles.forEach { it.mostrarDetalles() }
    }

    override fun mostrarMaterialesUsuario(usuario: Usuario) {
        println("Materiales prestados por ${usuario.nombre}:")
        prestamos[usuario]?.forEach { it.mostrarDetalles() }
    }
}

// Aplicamos las clases, interfaces del Sistema Biblioteca
fun main() {
    val biblioteca = Biblioteca()

    val libro1 = Libro("Quijote", "Cervantes", 1605, "Novela", 777)
    val revista1 = Revista("Zootopia", "Varios", 2022, "1234-5678", 10, 5, "NatGeo")

    val usuario1 = Usuario("Juana", "Pérez", 25)
    val usuario2 = Usuario("Jorge", "Natiles", 28)

    biblioteca.registrarMaterial(libro1)
    biblioteca.registrarMaterial(revista1)
    biblioteca.registrarUsuario(usuario1)
    biblioteca.registrarUsuario(usuario2)

    biblioteca.mostrarMaterialesDisponibles()
    biblioteca.prestar(usuario1, libro1)
    biblioteca.mostrarMaterialesUsuario(usuario1)
    biblioteca.mostrarMaterialesUsuario(usuario2)
    biblioteca.devolver(usuario1, libro1)
    biblioteca.mostrarMaterialesDisponibles()
}
