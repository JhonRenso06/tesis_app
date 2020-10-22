import 'package:mr_yupi/src/api/direccion_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';

class DireccionRepository {
  DireccionAPI _direccionAPI;

  DireccionRepository() {
    _direccionAPI = DireccionAPI();
  }

  Future<APIResponse<Paginate<Direccion>>> initialLoad() async {
    return await _direccionAPI.getDirecciones();
  }

  Future<APIResponse<Paginate<Direccion>>> loadMore(num currentPage) async {
    return await _direccionAPI.getDirecciones(page: currentPage + 1);
  }

  Future<APIResponse> createDireccion(Direccion direccion) async {
    return await _direccionAPI.createDireccion(direccion);
  }

  Future<APIResponse> updateDireccion(Direccion direccion) async {
    return await _direccionAPI.updateDireccion(direccion);
  }

  Future<APIResponse> predeterminadoDireccion(Direccion direccion) async {
    return await _direccionAPI.predeterminadoDireccion(direccion);
  }

  Future<APIResponse> deleteDireccion(Direccion direccion) async {
    return await _direccionAPI.deleteDireccion(direccion);
  }
}
