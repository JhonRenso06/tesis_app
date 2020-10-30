import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mr_yupi/src/api/auth_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';

class AuthRepository {
  AuthAPI _authAPI;
  FirebaseMessaging _messaging;

  AuthRepository() {
    _authAPI = AuthAPI();
    _messaging = FirebaseMessaging();
  }

  Future<APIResponse<Cliente>> register(Cliente cliente) async {
    return await _authAPI.register(cliente, await _messaging.getToken());
  }

  Future<APIResponse<Cliente>> login(Cliente cliente) async {
    return await _authAPI.login(cliente, await _messaging.getToken());
  }

  subscribeTokenMarket() async {
    await _authAPI.subscription(await _messaging.getToken());
  }

  Future<APIResponse<Cliente>> signOut() async {
    return await _authAPI.signOut(await _messaging.getToken());
  }

  Future<APIResponse<Cliente>> getCurrentClient() async {
    return await _authAPI.getCurrrentClient();
  }

  Future<APIResponse<Cliente>> updateMe(Cliente cliente) async {
    return await _authAPI.updateMe(cliente);
  }

  Future<APIResponse<Cliente>> changePassword(
      String currentPassword, String newPassword) async {
    return await _authAPI.changePassword(currentPassword, newPassword);
  }

  Future<APIResponse<Cliente>> recoverPassword(String email) async {
    return await _authAPI.recoverPassword(email);
  }
}
