import '../model/modelopersona.dart';
import '../controller/servicios.dart';

class ControladorOperaciones {
  final Servicios _servicios = Servicios();

  Future<List<ModeloPersona>> obtenerListaPersonas() async {
    return await _servicios.obtenerPersonas();
  }

  Future<void> agregarPersona(ModeloPersona persona) async {
    await _servicios.agregarPersona(persona);
  }

  Future<void> actualizarPersona(ModeloPersona persona) async {
    // NUEVA FUNCIÓN
    await _servicios.actualizarPersona(persona);
  }

  Future<void> eliminarPersona(String id) async {
    await _servicios.eliminarPersona(id);
  }
}
