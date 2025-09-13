/**
 * Descripción: App que muestra una imagen en pantalla y despliega un Toast con un mensaje personalizado.
 * Sebastian Castro
 * Fecha creación: 11/09/2025
 */

package com.example.ejercicio1

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.Toast

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val imageView = findViewById<ImageView>(R.id.myImage)

        imageView.setOnClickListener {
            Toast.makeText(this, "Adivina quién soy..", Toast.LENGTH_SHORT).show()
        }
    }
}
