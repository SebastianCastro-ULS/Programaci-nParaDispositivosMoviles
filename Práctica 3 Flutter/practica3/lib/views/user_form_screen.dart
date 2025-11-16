import 'package:flutter/material.dart';
import '../models/user.dart';

// Formulario para agregar o editar usuarios
class UserFormScreen extends StatefulWidget {
  final User? usuario;
  final int? indice;

  const UserFormScreen({super.key, this.usuario, this.indice});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _nombre;
  late String _correo;
  late int _edad;

  String _genero = 'Masculino';
  bool _activo = true;

  @override
  void initState() {
    super.initState();

    if (widget.usuario != null) {
      _nombre = widget.usuario!.nombre;
      _correo = widget.usuario!.correo;
      _edad = widget.usuario!.edad;
      _genero = widget.usuario!.genero;
      _activo = widget.usuario!.activo;
    } else {
      _nombre = '';
      _correo = '';
      _edad = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.usuario == null ? 'Agregar Usuario' : 'Editar Usuario'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              // Agrefamos validación
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'El nombre es obligatorio' : null,
                onSaved: (value) => _nombre = value!,
              ),

              const SizedBox(height: 15),

              // Validación también para edad
              TextFormField(
                initialValue: _edad == 0 ? "" : _edad.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una edad';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'La edad debe ser mayor a 0';
                  }
                  return null;
                },
                onSaved: (value) => _edad = int.parse(value!),
              ),

              const SizedBox(height: 15),

              TextFormField(
                initialValue: _correo,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  final emailRegex =
                      RegExp(r'^[^@]+@[^@]+\.[^@]+$'); // Validación para el correo
                  if (!emailRegex.hasMatch(value)) {
                    return 'Correo inválido';
                  }
                  return null;
                },
                onSaved: (value) => _correo = value!,
              ),

              const SizedBox(height: 20),

              const Text("Género"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Masculino'),
                      value: 'Masculino',
                      groupValue: _genero,
                      onChanged: (value) =>
                          setState(() => _genero = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Femenino'),
                      value: 'Femenino',
                      groupValue: _genero,
                      onChanged: (value) =>
                          setState(() => _genero = value!),
                    ),
                  ),
                ],
              ),

              SwitchListTile(
                title: const Text('Activo'),
                value: _activo,
                onChanged: (value) => setState(() => _activo = value),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final user = User(
                      nombre: _nombre,
                      genero: _genero,
                      activo: _activo,
                      edad: _edad,
                      correo: _correo,
                    );

                    Navigator.pop(context, user);
                  }
                },
                child:
                    Text(widget.usuario == null ? 'Guardar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
