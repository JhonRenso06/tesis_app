import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';

class EstablecimientoAPI extends API {
  EstablecimientoAPI() : super('/market/establecimientos');

  Future<APIResponse<Paginate<Departamento>>> getEstablecimientos(
      {page = 1, limit = 8}) async {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    var res = await get('', query: query, auth: true);
    if (res.hasException) {
      return res;
    }
    Paginate<Departamento> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(Departamento().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }
}
