import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/modelopersona.dart';

class Servicios {
  final String _baseUrl = "http://localhost:5000/api/personas";

  Future<List<ModeloPersona>> obtenerPersonas() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ModeloPersona.fromJson(item)).toList();
    } else {
      throw Exception("Error al cargar personas");
    }
  }

  Future<void> agregarPersona(ModeloPersona persona) async {
    await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(persona.toJson()),
    );
  }

  Future<void> actualizarPersona(ModeloPersona persona) async {
    // NUEVA FUNCIÓN
    final url = "$_baseUrl/${persona.id}";
    await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(persona.toJson()),
    );
  }

  Future<void> eliminarPersona(String id) async {
    final url = "$_baseUrl/$id";
    await http.delete(Uri.parse(url));
  }
}
