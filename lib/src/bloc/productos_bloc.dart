import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/resources/productos_repository.dart';

class ProductosBloc
    extends Cubit<APIResponse<Paginate<ProductoEstablecimiento>>> {
  ProductosRepository _repository;

  ProductosBloc()
      : super(APIResponse<Paginate<ProductoEstablecimiento>>().toLoading()) {
    _repository = ProductosRepository();
  }

  initialLoad(Establecimiento establecimiento) async {
    emit(state.toLoading());
    var result = await _repository.initialLoad(establecimiento);
    emit(result);
  }

  loadMore(Establecimiento establecimiento) async {
    if (state.data.items.length < state.data.meta.totalItems) {
      emit(state.toLoadMore());
      var result = await _repository.loadMore(
          establecimiento, state.data.meta.currentPage);
      result.data.combine(state.data);
      emit(result);
    }
  }

  addFavorito(int id, {bool refresh = false}) async {
    print("asd");
    try {
      ProductoEstablecimiento productoEstablecimiento =
          state.data.items.firstWhere((element) => element.producto.id == id);
      if (refresh) {
        productoEstablecimiento.producto.favorito = true;
        emit(state.toCompleted());
      } else {
        await _repository.addFavorite(productoEstablecimiento);
      }
    } catch (_) {
      print(_);
    }
  }

  removeFavorito(int id, {bool refresh = false}) async {
    try {
      ProductoEstablecimiento productoEstablecimiento =
          state.data.items.firstWhere((element) => element.producto.id == id);
      if (refresh) {
        productoEstablecimiento.producto.favorito = false;
        emit(state.toCompleted());
      } else {
        await _repository.removeFavorite(productoEstablecimiento);
      }
    } catch (_) {
      print(_);
    }
  }
}
