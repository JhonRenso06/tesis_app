import 'package:mr_yupi/src/api/establecimiento_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';

class EstablecimientoRepository {
  EstablecimientoAPI _establecimientoAPI;

  EstablecimientoRepository() {
    _establecimientoAPI = EstablecimientoAPI();
  }

  Future<APIResponse<Paginate<Departamento>>> initialLoad() async {
    return await _establecimientoAPI.getEstablecimientos();
  }
}
