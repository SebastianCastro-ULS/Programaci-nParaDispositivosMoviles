package com.example.act4perfil

import android.app.Activity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class ResumenActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_resumen)

        val usuario = intent.getSerializableExtra("usuario") as Usuario

        val tvResumen = findViewById<TextView>(R.id.tvResumen)
        tvResumen.text = """
            Nombre: ${usuario.nombre}
            Edad: ${usuario.edad}
            Ciudad: ${usuario.ciudad}
            Correo: ${usuario.correo}
        """.trimIndent()

        // Botones
        val btnConfirmar = findViewById<Button>(R.id.btnConfirmar)
        val btnEditar = findViewById<Button>(R.id.btnEditar)

        btnConfirmar.setOnClickListener {
            setResult(Activity.RESULT_OK) // Regresa OK → mostrará Toast en FormularioActivity
            finish()
        }

        btnEditar.setOnClickListener {
            setResult(Activity.RESULT_CANCELED) // Regresa sin cambios
            finish()
        }
    }
}
