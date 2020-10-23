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
      return APIResponse.fromResponse(res, null);
    }
    Paginate<Pedido> paginate = Paginate.fromMap(res.data);
    (res.data["items"] as List).forEach((element) {
      paginate.items.add(Pedido().fromMap(element));
    });
    return APIResponse.fromResponse(res, paginate);
  }

  Future<APIResponse<Pedido>> crearPedido(Pedido pedido) async {
    var res = await post('', body: pedido.toMap(), auth: true);
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    return APIResponse.fromResponse(res, pedido);
  }

  Future<APIResponse<Pedido>> ultimoPedido() async {
    var res = await get('/ultimo', auth: true);
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    return APIResponse.fromResponse(res, Pedido().fromMap(res.data));
  }
}
