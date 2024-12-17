import 'package:flutter/material.dart';
import '../controller/controladoroperaciones.dart';
import '../model/modelopersona.dart';
import '../widgets/formulario.dart';
import '../widgets/widgetalerta.dart';

class VistaPersonas extends StatefulWidget {
  const VistaPersonas({super.key});

  @override
  State<VistaPersonas> createState() => _VistaPersonasState();
}

class _VistaPersonasState extends State<VistaPersonas> {
  final ControladorOperaciones _controlador = ControladorOperaciones();
  List<ModeloPersona> _personas = [];

  @override
  void initState() {
    super.initState();
    _cargarPersonas();
  }

  Future<void> _cargarPersonas() async {
    try {
      final data = await _controlador.obtenerListaPersonas();
      setState(() {
        _personas = data;
      });
    } catch (e) {
      _mostrarAlerta("Error", "No se pudieron cargar las personas.");
    }
  }

  Future<void> _agregarPersona(
      String nombre, String apellido, String telefono) async {
    try {
      final nuevaPersona = ModeloPersona(
        id: "",
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
      );
      await _controlador.agregarPersona(nuevaPersona);
      _mostrarAlerta("Éxito", "Persona agregada correctamente.");
      _cargarPersonas();
    } catch (e) {
      _mostrarAlerta("Error", "No se pudo agregar la persona.");
    }
  }

  Future<void> _editarPersona(ModeloPersona persona, String nombre,
      String apellido, String telefono) async {
    try {
      final personaEditada = ModeloPersona(
        id: persona.id,
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
      );
      await _controlador.actualizarPersona(personaEditada);
      _mostrarAlerta("Éxito", "Persona editada correctamente.");
      _cargarPersonas();
    } catch (e) {
      _mostrarAlerta("Error", "No se pudo editar la persona.");
    }
  }

  void _mostrarAlerta(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (context) => WidgetAlerta(titulo: titulo, mensaje: mensaje),
    );
  }

  void _mostrarFormulario({ModeloPersona? persona}) {
    showDialog(
      context: context,
      builder: (context) => FormularioPersona(
        persona: persona,
        onGuardar: (nombre, apellido, telefono) {
          if (persona == null) {
            _agregarPersona(nombre, apellido, telefono);
          } else {
            _editarPersona(persona, nombre, apellido, telefono);
          }
        },
      ),
    );
  }

  Future<void> _eliminarPersona(String id) async {
    try {
      await _controlador.eliminarPersona(id);
      _mostrarAlerta("Éxito", "Persona eliminada correctamente.");
      _cargarPersonas();
    } catch (e) {
      _mostrarAlerta("Error", "No se pudo eliminar la persona.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personas"),
        backgroundColor: const Color.fromARGB(255, 70, 130, 180),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = (constraints.maxWidth ~/ 200).clamp(2, 6);
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 200, 220, 240),
                  Color.fromARGB(255, 171, 212, 230),
                  Color.fromARGB(255, 70, 130, 180),
                ],
              ),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _personas.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 19/20,
              ),
              itemBuilder: (context, index) {
                final persona = _personas[index];
                return Card(
                  color: Colors.white.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 28), // Espacio superior
                      CircleAvatar(
                        radius: 25, 
                        backgroundColor: const Color.fromARGB(255, 70, 130, 180),
                        child: Text(
                          persona.nombre[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${persona.nombre} ${persona.apellido}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, 
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Teléfono: ${persona.telefono}",
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const Spacer(), // Empuja los botones hacia abajo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _mostrarFormulario(persona: persona),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _eliminarPersona(persona.id),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // Espacio inferior
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color.fromARGB(255, 70, 130, 180)),
      ),
    );
  }
}
