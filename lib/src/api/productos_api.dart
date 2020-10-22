import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class ProductosAPI extends API {
  ProductosAPI() : super('/market/productos');

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> getProductos(
      Establecimiento establecimiento,
      {page = 1,
      limit = 8}) async {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    var res = await get("/${establecimiento.id}", query: query);
    if (res.hasException) {
      return res;
    }
    Paginate<ProductoEstablecimiento> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(ProductoEstablecimiento().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> getSearch(
      Establecimiento establecimiento, String search,
      {page = 1, limit = 8}) async {
    Map<String, dynamic> query = {
      'page': page,
      'limit': limit,
      'search': search
    };
    var res = await get("/${establecimiento.id}", query: query);
    if (res.hasException) {
      return res;
    }
    Paginate<ProductoEstablecimiento> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(ProductoEstablecimiento().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> getCategory(
      Establecimiento establecimiento, Categoria categoria,
      {page = 1, limit = 8}) async {
    Map<String, dynamic> query = {
      'page': page,
      'limit': limit,
      'category': categoria.id
    };
    var res = await get("/${establecimiento.id}", query: query);
    if (res.hasException) {
      return res;
    }
    Paginate<ProductoEstablecimiento> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(ProductoEstablecimiento().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }

  Future<APIResponse<Paginate<ProductoEstablecimiento>>> getFavoritos(
      Establecimiento establecimiento, List<num> ids,
      {page = 1, limit = 8}) async {
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
