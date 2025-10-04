package com.example.editornotas

/**
 * By Sebastian Castro
 * Descripción:Permitir al usuario escribir una nota, enviarla a otra actividad para elegir compartirla o volver a editar.
 *
 */
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity

class EditorActivity : AppCompatActivity() {

    private lateinit var etNota: EditText

    private val opcionesLauncher = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()
    ) { result ->
        if (result.resultCode == RESULT_OK) {
            // Recuperar texto devuelto para seguir editando
            val textoDevuelto = result.data?.getStringExtra("nota")
            etNota.setText(textoDevuelto)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_editor)

        etNota = findViewById(R.id.etNota)
        val btnCompartir = findViewById<Button>(R.id.btnCompartir)

        if (savedInstanceState != null) {
            etNota.setText(savedInstanceState.getString("nota"))
        }

        btnCompartir.setOnClickListener {
            val intent = Intent(this, OpcionesActivity::class.java)
            intent.putExtra("nota", etNota.text.toString())
            opcionesLauncher.launch(intent)
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putString("nota", etNota.text.toString())
    }
}
