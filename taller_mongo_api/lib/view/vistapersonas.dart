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
        id: persona.id, // Aquí aseguramos que el ID sea el correcto
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
      );
      await _controlador
          .actualizarPersona(personaEditada); // Llamada a la función correcta
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personas")),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (context, index) {
          final persona = _personas[index];
          return ListTile(
            title: Text("${persona.nombre} ${persona.apellido}"),
            subtitle: Text("Teléfono: ${persona.telefono}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(),
        child: const Icon(Icons.add),
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
}
