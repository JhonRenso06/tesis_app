import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/resources/direccion_repository.dart';

class DireccionBloc extends Cubit<APIResponse<Paginate<Direccion>>> {
  DireccionRepository _repository;

  DireccionBloc() : super(APIResponse()) {
    _repository = DireccionRepository();
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

  createDireccion(Direccion direccion) async {
    emit(state.toLoading());
    var result = await _repository.createDireccion(direccion);
    var current = state.toCompleted();
    current.exception = result.exception;
    current.message = result.message;
    emit(current);
  }

  updateDireccion(Direccion direccion) async {
    emit(state.toLoading());
    var result = await _repository.updateDireccion(direccion);
    var current = state.toCompleted();
    current.exception = result.exception;
    current.message = result.message;
    emit(current);
  }

  predeterminadoDireccion(Direccion direccion) async {
    var result = await _repository.predeterminadoDireccion(direccion);
    var current = state.toCompleted();
    current.exception = result.exception;
    current.message = result.message;
    print(direccion.descripcion);
    current.data.items.forEach((element) {
      if (direccion.id == element.id) {
        element.predeterminado = true;
      } else {
        element.predeterminado = false;
      }
    });
    emit(current);
  }

  deleteDireccion(Direccion direccion) async {
    emit(state.toLoading());
    var result = await _repository.deleteDireccion(direccion);
    var current = state.toCompleted();
    current.exception = result.exception;
    current.message = result.message;
    emit(current);
  }

  Direccion get direccionDefault {
    Direccion direccion;
    state.data.items.forEach((element) {
      if (element != null && element.predeterminado) {
        direccion = element;
      }
    });
    return direccion;
  }
}
