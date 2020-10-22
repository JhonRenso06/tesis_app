import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/resources/categoria_repository.dart';

class CategoriaBloc extends Cubit<APIResponse<Paginate<Categoria>>> {
  CategoriaRepository _repository;

  CategoriaBloc() : super(APIResponse()) {
    _repository = CategoriaRepository();
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
}
