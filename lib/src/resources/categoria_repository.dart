import 'package:mr_yupi/src/api/categoria_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';

class CategoriaRepository {
  CategoriaAPI _direccionAPI;

  CategoriaRepository() {
    _direccionAPI = CategoriaAPI();
  }

  Future<APIResponse<Paginate<Categoria>>> initialLoad() async {
    return await _direccionAPI.getCategoria();
  }

  Future<APIResponse<Paginate<Categoria>>> loadMore(num currentPage) async {
    return await _direccionAPI.getCategoria(page: currentPage + 1);
  }
}
