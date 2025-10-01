package com.example.recyclerviewapp.adapter

import android.app.AlertDialog
import android.view.View
import android.widget.EditText
import android.widget.ImageButton
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.recyclerviewapp.R
import com.example.recyclerviewapp.Usuario

class UsuarioViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    private val txtNombre = view.findViewById<TextView>(R.id.txtNombre)
    private val txtEdad = view.findViewById<TextView>(R.id.txtEdad)
    private val txtCorreo = view.findViewById<TextView>(R.id.txtCorreo)
    private val btnDelete = view.findViewById<ImageButton>(R.id.btnEliminar)

    fun bind(
        user: Usuario,
        onDelete: (Int) -> Unit,
        onEdit: (Int, Usuario) -> Unit
    ) {
        txtNombre.text = user.nombre
        txtEdad.text = user.edad.toString()
        txtCorreo.text = user.email

        btnDelete.setOnClickListener {
            val pos = bindingAdapterPosition
            if (pos != RecyclerView.NO_POSITION) {
                onDelete(pos)
            }
        }

        itemView.setOnLongClickListener {
            val pos = bindingAdapterPosition
            if (pos != RecyclerView.NO_POSITION) {
                AlertDialog.Builder(itemView.context)
                    .setTitle("Acción")
                    .setItems(arrayOf("Editar", "Eliminar")) { _, which ->
                        when (which) {
                            0 -> showEditDialog(user, pos, onEdit) // Editar
                            1 -> onDelete(pos) // Eliminar
                        }
                    }
                    .show()
            }
            true
        }
    }

    private fun showEditDialog(user: Usuario, pos: Int, onEdit: (Int, Usuario) -> Unit) {
        val context = itemView.context
        val dialogView = View.inflate(context, R.layout.dialog_edit_usuario, null)

        val editNombre = dialogView.findViewById<EditText>(R.id.editNombre)
        val editEdad = dialogView.findViewById<EditText>(R.id.editEdad)
        val editCorreo = dialogView.findViewById<EditText>(R.id.editCorreo)

        // valores
        editNombre.setText(user.nombre)
        editEdad.setText(user.edad.toString())
        editCorreo.setText(user.email)

        AlertDialog.Builder(context)
            .setTitle("Editar usuario")
            .setView(dialogView)
            .setPositiveButton("Guardar") { _, _ ->
                user.nombre = editNombre.text.toString()
                user.edad = editEdad.text.toString().toIntOrNull() ?: user.edad
                user.email = editCorreo.text.toString()
                onEdit(pos, user) // Llamamos callback para actualizar adapter
            }
            .setNegativeButton("Cancelar", null)
            .show()
    }
}
