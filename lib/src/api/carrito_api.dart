import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class CarritoAPI extends API {
  CarritoAPI() : super('/market/productos');

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> getCarrito(
      Establecimiento establecimiento, List<num> ids,
      {page = 1, limit = 1000}) async {
    Map<String, dynamic> query = {
      'page': page,
      'limit': limit,
      'ids': ids.join(',')
    };
    var res = await get("/favoritos/${establecimiento.id}", query: query);
    if (res.hasException) {
      return res;
    }
    Paginate<ProductoEstablecimiento> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(ProductoEstablecimiento().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }
}
