import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/resources/departamento_repository.dart';

class DepartamentoBloc extends Cubit<APIResponse<List<Departamento>>> {
  DepartamentoRepository _repository;

  DepartamentoBloc() : super(APIResponse()) {
    _repository = DepartamentoRepository();
  }

  getDepartamentos() async {
    emit(state.toLoading());
    var data = await _repository.getDepartamentos();
    emit(data);
  }
}
