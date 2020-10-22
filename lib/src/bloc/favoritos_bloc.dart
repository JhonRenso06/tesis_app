import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/resources/productos_repository.dart';

class FavoritosBloc
    extends Cubit<APIResponse<Paginate<ProductoEstablecimiento>>> {
  ProductosRepository _repository;

  FavoritosBloc()
      : super(APIResponse<Paginate<ProductoEstablecimiento>>().toLoading()) {
    _repository = ProductosRepository();
  }

  initialLoad(Establecimiento establecimiento) async {
    emit(state.toLoading());
    var result = await _repository.initialLoadFavoritos(establecimiento);
    emit(result);
  }

  initialLoadNoLoading(Establecimiento establecimiento) async {
    var result = await _repository.initialLoadFavoritos(establecimiento);
    emit(result);
  }

  loadMore(Establecimiento establecimiento) async {
    if (state.data.items.length < state.data.meta.totalItems) {
      emit(state.toLoadMore());
      var result = await _repository.loadMoreFavoritos(
          establecimiento, state.data.meta.currentPage);
      result.data.combine(state.data);
      emit(result);
    }
  }

  removeFavorito(int id) async {
    try {
      ProductoEstablecimiento productoEstablecimiento =
          state.data.items.firstWhere((element) => element.producto.id == id);
      await _repository.removeFavorite(productoEstablecimiento);
    } catch (_) {}
  }
}
