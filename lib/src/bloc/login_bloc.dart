import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/bloc_state.dart';
import 'package:mr_yupi/src/model/api_exception.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/resources/auth_repository.dart';

class LoginBloc extends Cubit<BlocState<APIMessage>> {
  AuthRepository _repository;

  LoginBloc() : super(InitialState()) {
    _repository = AuthRepository();
  }

  login(Cliente cliente) async {
    try {
      emit(LoadingState<APIMessage>());
      APIMessage message = await _repository.login(cliente);
      emit(LoadedState<APIMessage>(data: message));
    } on APIException catch (ex) {
      emit(ErrorState<APIMessage>(exception: ex));
    } catch (ex) {
      print(ex);
      emit(ErrorState<APIMessage>(
          exception:
              APIException(message: 'Error desconocido, intente mas tarde')));
    }
  }
}
