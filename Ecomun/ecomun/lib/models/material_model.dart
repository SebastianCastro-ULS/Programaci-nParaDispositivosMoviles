class MaterialModel {
  final String id;           // Identificador único del material
  final String name;         // Nombre del materia
  final String description;  // Descripción de qué incluye
  final String icon;         // Nombre del ícono a usar en la UI
  final String tips;         // Consejos para reciclar correctamente

//COnstructor
  MaterialModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.tips,
  });
}