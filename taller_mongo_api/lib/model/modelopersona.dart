class ModeloPersona {
  final String id;
  final String nombre;
  final String apellido;
  final String telefono;

  ModeloPersona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  // Método para convertir JSON a objeto ModeloPersona
  factory ModeloPersona.fromJson(Map<String, dynamic> json) {
    return ModeloPersona(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      telefono: json['telefono'] ?? '',
    );
  }

  // Método para convertir objeto ModeloPersona a JSON
  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "telefono": telefono,
    };
  }
}
