package com.example.recyclerviewapp.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.recyclerviewapp.R
import com.example.recyclerviewapp.Usuario

class UsuarioAdapter(var items: ArrayList<Usuario>) : RecyclerView.Adapter<UsuarioViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UsuarioViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_usuario, parent, false)
        return UsuarioViewHolder(view)
    }

    override fun onBindViewHolder(holder: UsuarioViewHolder, position: Int) {
        val user = items[position]
        holder.bind(
            user,
            { pos -> removeUser(pos) },                   // eliminar
            { pos, usuario -> updateUser(pos, usuario) }  // editar
        )
    }

    override fun getItemCount(): Int = items.size

    fun addUser(user: Usuario) {
        items.add(user)
        notifyItemInserted(items.size - 1)
    }

    fun removeUser(position: Int) {
        if (position in items.indices) {
            items.removeAt(position)
            notifyItemRemoved(position)
        }
    }

    fun updateUser(position: Int, usuario: Usuario) {
        if (position in items.indices) {
            items[position] = usuario
            notifyItemChanged(position) 
        }
    }
}
