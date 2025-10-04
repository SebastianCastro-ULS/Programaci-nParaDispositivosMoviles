package com.example.editornotas

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class OpcionesActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_opciones)

        val nota = intent.getStringExtra("nota") ?: ""

        val tvNota = findViewById<TextView>(R.id.tvNota)
        val btnCorreo = findViewById<Button>(R.id.btnCorreo)
        val btnEditar = findViewById<Button>(R.id.btnEditar)

        tvNota.text = nota

        btnCorreo.setOnClickListener {
            Toast.makeText(this, "Compartido por correo", Toast.LENGTH_SHORT).show()
        }

        btnEditar.setOnClickListener {
            val intent = Intent()
            intent.putExtra("nota", nota)
            setResult(Activity.RESULT_OK, intent)
            finish()
        }
    }
}
