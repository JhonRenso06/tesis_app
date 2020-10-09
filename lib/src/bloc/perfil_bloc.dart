import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/bloc_state.dart';
import 'package:mr_yupi/src/model/api_exception.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/resources/auth_repository.dart';

class PerfilBloc extends Cubit<BlocState<Cliente>> {
  AuthRepository _repository;

  PerfilBloc() : super(InitialState()) {
    _repository = AuthRepository();
  }

  getCurrentClient() async {
    try {
      emit(LoadingState<Cliente>());
      Cliente cliente = await _repository.getCurrentClient();
      emit(LoadedState<Cliente>(data: cliente));
    } on APIException catch (ex) {
      emit(ErrorState<Cliente>(exception: ex));
    } catch (ex) {
      print(ex);
      emit(ErrorState<Cliente>(
          exception:
              APIException(message: 'Error desconocido, intente mas tarde')));
    }
  }
}
