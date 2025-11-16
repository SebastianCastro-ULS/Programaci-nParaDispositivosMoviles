// User: representa un usuario dentro la app. Se añadió también edad y correo.
class User {
  String nombre;
  String genero;
  bool activo;
  int edad; // Nuevo campo
  String correo; // Nuevo campo

  User({
    required this.nombre,
    required this.genero,
    required this.activo,
    required this.edad,
    required this.correo,
  });
}
