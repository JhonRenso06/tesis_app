import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';

class DireccionAPI extends API {
  DireccionAPI() : super('/market/direcciones');

  Future<APIResponse<Paginate<Direccion>>> getDirecciones(
      {page = 1, limit = 10}) async {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    var res = await get('', query: query, auth: true);
    if (res.hasException) {
      return res;
    }
    Paginate<Direccion> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(Direccion().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }

  Future<APIResponse> createDireccion(Direccion direccion) async {
    print(direccion.toMap());
    var res = await post('', body: direccion.toMap(), auth: true);
    return APIResponse.fromResponse(res, null);
  }

  Future<APIResponse> updateDireccion(Direccion direccion) async {
    print(direccion.toMap());
    var res =
        await put('', id: direccion.id, body: direccion.toMap(), auth: true);
    return APIResponse.fromResponse(res, null);
  }

  Future<APIResponse> predeterminadoDireccion(Direccion direccion) async {
    var res = await put('',
        id: direccion.id, body: {'predeterminado': true}, auth: true);
    return APIResponse.fromResponse(res, null);
  }

  Future<APIResponse> deleteDireccion(Direccion direccion) async {
    var res = await delete('', direccion.id, auth: true);
    return APIResponse.fromResponse(res, null);
  }
}
