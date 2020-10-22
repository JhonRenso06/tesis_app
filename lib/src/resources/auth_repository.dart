import 'package:mr_yupi/src/api/auth_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';

class AuthRepository {
  AuthAPI _authAPI;

  AuthRepository() {
    _authAPI = AuthAPI();
  }

  Future<APIResponse<Cliente>> register(Cliente cliente) async {
    return await _authAPI.register(cliente);
  }

  Future<APIResponse<Cliente>> login(Cliente cliente) async {
    return await _authAPI.login(cliente);
  }

  Future<APIResponse<Cliente>> signOut() async {
    return await _authAPI.signOut();
  }

  Future<APIResponse<Cliente>> getCurrentClient() async {
    return await _authAPI.getCurrrentClient();
  }

  Future<APIResponse<Cliente>> updateMe(Cliente cliente) async {
    return await _authAPI.updateMe(cliente);
  }
}
