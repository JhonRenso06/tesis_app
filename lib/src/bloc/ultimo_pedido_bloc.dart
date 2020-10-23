import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/resources/pedido_repository.dart';

class UltimoPedidoBloc extends Cubit<APIResponse<Pedido>> {
  PedidoRepository _repository;

  UltimoPedidoBloc() : super(APIResponse<Pedido>()) {
    _repository = PedidoRepository();
  }

  loadPedido() async {
    var result = await _repository.ultimoPedido();
    emit(result);
  }
}
