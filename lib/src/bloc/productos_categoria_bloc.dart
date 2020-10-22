import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/resources/productos_repository.dart';

class ProductosCategoriaBloc
    extends Cubit<APIResponse<Paginate<ProductoEstablecimiento>>> {
  ProductosRepository _repository;

  ProductosCategoriaBloc()
      : super(APIResponse<Paginate<ProductoEstablecimiento>>().toLoading()) {
    _repository = ProductosRepository();
  }

  initialLoad(Establecimiento establecimiento, Categoria categoria) async {
    emit(state.toLoading());
    var result =
        await _repository.initialLoadCategoria(establecimiento, categoria);
    emit(result);
  }

  loadMore(Establecimiento establecimiento, Categoria categoria) async {
    if (state.data.items.length < state.data.meta.totalItems) {
      emit(state.toLoadMore());
      var result = await _repository.loadMoreCategoria(
          establecimiento, categoria, state.data.meta.currentPage);
      result.data.combine(state.data);
      emit(result);
    }
  }

  addFavorito(int id) async {
    try {
      ProductoEstablecimiento productoEstablecimiento =
          state.data.items.firstWhere((element) => element.producto.id == id);
      await _repository.addFavorite(productoEstablecimiento);
    } catch (_) {}
  }

  removeFavorito(int id) async {
    try {
      ProductoEstablecimiento productoEstablecimiento =
          state.data.items.firstWhere((element) => element.producto.id == id);
      await _repository.removeFavorite(productoEstablecimiento);
    } catch (_) {}
  }
}
