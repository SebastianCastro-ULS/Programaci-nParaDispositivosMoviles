package com.example.recyclerviewapp

class UsuarioProvider private constructor(){

    companion object{
        val instance: UsuarioProvider = UsuarioProvider()
    }

    val listaUsuario = arrayListOf<Usuario>(
        Usuario("Miguel", 20, "miguel@gmail.com", "1234"),
        Usuario("Maria", 20, "maria@gmail.com", "1234"),
        Usuario("Pedro", 20, "pedro@gmail.com", "1234"),
        Usuario("Isabel", 20, "isabel@gmail.com", "1234"),
        Usuario("Miguel", 20, "miguel@gmail.com", "1234"),
        Usuario("Maria", 20, "maria@gmail.com", "1234"),
        Usuario("Pedro", 20, "pedro@gmail.com", "1234"),
        Usuario("Isabel", 20, "isabel@gmail.com", "1234"),
        Usuario("Miguel", 20, "miguel@gmail.com", "1234"),
        Usuario("Maria", 20, "maria@gmail.com", "1234"),
        Usuario("Pedro", 20, "pedro@gmail.com", "1234"),
        Usuario("Isabel", 20, "isabel@gmail.com", "1234"),
        Usuario("Miguel", 20, "miguel@gmail.com", "1234"),
        Usuario("Maria", 20, "maria@gmail.com", "1234"),
        Usuario("Pedro", 20, "pedro@gmail.com", "1234"),
        Usuario("Isabel", 20, "isabel@gmail.com", "1234")
    )

}