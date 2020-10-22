import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/resources/pedido_repository.dart';

class FinalizarPedidoBloc extends Cubit<APIResponse<Pedido>> {
  PedidoRepository _repository;

  FinalizarPedidoBloc() : super(APIResponse<Pedido>().toLoading()) {
    _repository = PedidoRepository();
  }

  crearPedido(Establecimiento establecimiento, Pedido pedido) async {
    pedido.establecimiento = establecimiento;
    if (pedido.metodoDePago == null) {
      pedido.metodoDePago = MetodoDePago.EFECTIVO;
    }
    var result = await _repository.crearPedido(pedido);
    emit(result);
  }
}
