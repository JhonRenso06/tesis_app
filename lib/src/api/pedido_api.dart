import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/pedido.dart';

class PedidoAPI extends API {
  PedidoAPI() : super('/market/pedidos');

  Future<APIResponse<Paginate<Pedido>>> getPedidos(
      {page = 1, limit = 8}) async {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    var res = await get('', query: query, auth: true);
    if (res.hasException) {
      return res;
    }
    Paginate<Pedido> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(Pedido().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }
}
