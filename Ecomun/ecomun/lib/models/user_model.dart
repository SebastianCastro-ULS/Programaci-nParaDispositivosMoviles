class UserModel {
  final String id;           // Identificador único del usuario
  final String name;         // Nombre completo
  final String email;        // Correo electrónico 
  final String? location;    // Ubicación del usuario 


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.location,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? location,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        location: location ?? this.location,
      );
}