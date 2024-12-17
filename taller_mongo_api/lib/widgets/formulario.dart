import 'package:flutter/material.dart';
import '../model/modelopersona.dart';

class FormularioPersona extends StatefulWidget {
  final ModeloPersona? persona;
  final Function(String, String, String) onGuardar;

  const FormularioPersona({
    super.key,
    this.persona,
    required this.onGuardar,
  });

  @override
  State<FormularioPersona> createState() => _FormularioPersonaState();
}

class _FormularioPersonaState extends State<FormularioPersona> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();

    // Inicializa controladores con valores existentes si se edita
    _nombreController =
        TextEditingController(text: widget.persona?.nombre ?? "");
    _apellidoController =
        TextEditingController(text: widget.persona?.apellido ?? "");
    _telefonoController =
        TextEditingController(text: widget.persona?.telefono ?? "");
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      widget.onGuardar(
        _nombreController.text,
        _apellidoController.text,
        _telefonoController.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.persona == null ? "Agregar Persona" : "Editar Persona"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
              validator: (value) => value!.isEmpty ? "Ingrese un nombre" : null,
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: "Apellido"),
              validator: (value) =>
                  value!.isEmpty ? "Ingrese un apellido" : null,
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value!.isEmpty ? "Ingrese un teléfono" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _guardar,
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
