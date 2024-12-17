import 'package:flutter/material.dart';

class WidgetAlerta extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const WidgetAlerta({
    super.key,
    required this.titulo,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}
