import 'package:mr_yupi/src/api/auth_api.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/cliente.dart';

class AuthRepository {
  AuthAPI _authAPI;

  AuthRepository() {
    _authAPI = AuthAPI();
  }

  Future<APIMessage> register(Cliente cliente) async {
    return await _authAPI.register(cliente);
  }

  Future<APIMessage> login(Cliente cliente) async {
    return await _authAPI.login(cliente);
  }

  Future<void> signOut() async {
    await _authAPI.signOut();
  }

  Future<Cliente> getCurrentClient() async {
    return await _authAPI.getCurrrentClient();
  }
}
