import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';

class CategoriaAPI extends API {
  CategoriaAPI() : super('/market/categorias');

  Future<APIResponse<Paginate<Categoria>>> getCategoria(
      {page = 1, limit = 8}) async {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    var res = await get('', query: query, auth: true);
    if (res.hasException) {
      return res;
    }
    Paginate<Categoria> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(Categoria().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }
}
