import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/resources/pedido_repository.dart';

class PedidoBloc extends Cubit<APIResponse<Paginate<Pedido>>> {
  PedidoRepository _repository;

  PedidoBloc() : super(APIResponse()) {
    _repository = PedidoRepository();
  }

  initialLoad() async {
    emit(state.toLoading());
    var result = await _repository.initialLoad();
    emit(result);
  }

  loadMore() async {
    if (state.data.items.length < state.data.meta.totalItems) {
      emit(state.toLoadMore());
      var result = await _repository.loadMore(state.data.meta.currentPage);
      result.data.combine(state.data);
      emit(result);
    }
  }

  cancelar(Pedido pedido) async {
    await _repository.cancelarPedido(pedido);
  }
}
