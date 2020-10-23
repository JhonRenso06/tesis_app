import 'package:mr_yupi/src/api/pedido_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/pedido.dart';

class PedidoRepository {
  PedidoAPI _pedidoAPI;

  PedidoRepository() {
    _pedidoAPI = PedidoAPI();
  }

  Future<APIResponse<Paginate<Pedido>>> initialLoad() async {
    return await _pedidoAPI.getPedidos();
  }

  Future<APIResponse<Paginate<Pedido>>> loadMore(num currentPage) async {
    return await _pedidoAPI.getPedidos(page: currentPage + 1);
  }

  Future<APIResponse<Pedido>> crearPedido(Pedido pedido) async {
    return await _pedidoAPI.crearPedido(pedido);
  }

  Future<APIResponse<Pedido>> ultimoPedido() async {
    return await _pedidoAPI.ultimoPedido();
  }
}
