package com.example.recyclerviewapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.recyclerviewapp.adapter.UsuarioAdapter

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val recyclerView = findViewById<RecyclerView>(R.id.recyclerUsuarios)

        val usuarios = UsuarioProvider.instance.listaUsuario

        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = UsuarioAdapter(usuarios)
    }
}