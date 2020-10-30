import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/resources/auth_repository.dart';

class PerfilBloc extends Cubit<APIResponse<Cliente>> {
  AuthRepository _repository;

  PerfilBloc() : super(APIResponse()) {
    _repository = AuthRepository();
  }

  getCurrentClient() async {
    emit(state.toLoading());
    var response = await _repository.getCurrentClient();
    emit(response);
  }

  Future<Cliente> getCliente() async {
    return (await _repository.getCurrentClient()).data;
  }

  updateMe(Cliente cliente) async {
    emit(state.toLoading());
    var response = await _repository.updateMe(cliente);
    emit(response);
  }

  changePassword(String currentPassword, String newPassword) async {
    emit(state.toLoading());
    var response =
        await _repository.changePassword(currentPassword, newPassword);
    emit(response);
  }

  recoverPassword(String email) async {
    emit(state.toLoading());
    var response = await _repository.recoverPassword(email);
    emit(response);
  }

  signOut() async {
    var response = await _repository.signOut();
    emit(response);
  }

  login(Cliente cliente) async {
    emit(state.toLoading());
    var response = await _repository.login(cliente);
    emit(response);
  }

  register(Cliente cliente) async {
    emit(state.toLoading());
    var response = await _repository.register(cliente);
    emit(response);
  }
}
