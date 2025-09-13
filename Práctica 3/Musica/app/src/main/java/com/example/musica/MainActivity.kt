/**
 * Descripción: App que implementa un reproductor de música básico con botones
 *              para reproducir, pausar y detener un archivo de audio local.
 * Sebastian Castro
 * Fecha: 12/09/2025
 */
/**
 * Descripción: Reproductor de música básico con botones para reproducir, pausar y detener.
 * Autor: [Tu Nombre]
 * Fecha creación: 12/09/2025
 * Fecha última modificación: 12/09/2025
 */

package com.example.musica

import android.media.MediaPlayer
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class MainActivity : AppCompatActivity() {

    private var reproductor: MediaPlayer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val botonReproducir = findViewById<Button>(R.id.botonReproducir)
        val botonPausar = findViewById<Button>(R.id.botonPausar)
        val botonDetener = findViewById<Button>(R.id.botonDetener)

        // Reproducir
        botonReproducir.setOnClickListener {
            if (reproductor == null) {
                reproductor = MediaPlayer.create(this, R.raw.milo)
            }
            reproductor?.start()
        }

        // Pausar
        botonPausar.setOnClickListener {
            reproductor?.pause()
        }

        // Detener
        botonDetener.setOnClickListener {
            reproductor?.stop()
            reproductor?.release()
            reproductor = null
        }
    }
}
