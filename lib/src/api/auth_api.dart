import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:mr_yupi/src/model/token_data.dart';

class AuthAPI extends API {
  AuthAPI() : super('');

  Future<APIResponse<Cliente>> login(Cliente cliente, String nToken) async {
    Map<String, dynamic> body = {
      'correo': cliente.correo,
      'password': cliente.password
    };

    var res = await post('/auth/clientes/signin', body: body);
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    var token = TokenData().fromMap(res.data);
    await _saveToken(token);
    await post("/market/me/token/$nToken", auth: true);
    return APIResponse.fromResponse(
      res,
      (await getCurrrentClient()).data,
    );
  }

  Future<APIResponse<Cliente>> register(Cliente cliente, String nToken) async {
    var res = await post('/auth/clientes/signup', body: cliente.toMap());
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    var token = TokenData().fromMap(res.data);
    await _saveToken(token);
    await post("/market/me/token/$nToken", auth: true);
    return APIResponse.fromResponse(
      res,
      (await getCurrrentClient()).data,
    );
  }

  Future<APIResponse<Cliente>> updateMe(Cliente cliente) async {
    var res = await put('/market/me', body: cliente.toMap(), auth: true);
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    await _saveData(cliente);
    return APIResponse.fromResponse(res, null);
  }

  Future<APIResponse<Cliente>> changePassword(
      String currentPassword, String newPassword) async {
    var res = await put(
      '/market/me/secure',
      body: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      auth: true,
    );
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    return APIResponse.fromResponse(res, null);
  }

  Future<APIResponse<Cliente>> recoverPassword(String email) async {
    var res = await post('/auth/clientes/recover', body: {'correo': email});
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    return APIResponse.fromResponse(res, null);
  }

  Future<void> subscription(String token) async {
    if (await storage.read(key: "subscription") == null) {
      await post('/market/me/notification/subscription/$token');
      await storage.write(key: "subscription", value: "true");
      print("Se guardo");
    } else {
      print("Guardado");
    }
  }

  Future<APIResponse<Cliente>> getCurrrentClient() async {
    Map<String, String> data = await storage.readAll();
    if (data['tkr_access_token'] == null) {
      return APIResponse<Cliente>(
        data: null,
        exception: null,
        message: null,
      );
    }
    String documento = data['tkr_documento'];
    if (documento.length == 11) {
      return APIResponse<Cliente>(
        data: ClienteJuridico(
          correo: data['tkr_email'],
          documento: documento,
          razonSocial: data['tkr_name'],
        ),
        exception: null,
        message: null,
      );
    } else {
      return APIResponse<Cliente>(
        data: ClienteNatural(
          correo: data['tkr_email'],
          documento: documento,
          nombre: data['tkr_name'],
          apellidos: data['tkr_last_name'],
        ),
        exception: null,
        message: null,
      );
    }
  }

  Future<APIResponse<Cliente>> signOut(String token) async {
    await delete("/market/me/token/$token", null, auth: true);
    await storage.deleteAll();
    return APIResponse<Cliente>(
      data: null,
      exception: null,
      message: null,
    );
  }

  Future<void> _saveToken(TokenData tokenData) async {
    await storage.write(key: 'tkr_email', value: tokenData.email);
    await storage.write(key: 'tkr_name', value: tokenData.name);
    await storage.write(key: 'tkr_last_name', value: tokenData.lastName);
    await storage.write(key: 'tkr_documento', value: tokenData.documento);
    await storage.write(key: 'tkr_access_token', value: tokenData.accessToken);
  }

  Future<void> _saveData(Cliente cliente) async {
    if (cliente is ClienteJuridico) {
      await storage.write(key: 'tkr_name', value: cliente.razonSocial);
      await storage.write(key: 'tkr_last_name', value: "");
      await storage.write(key: 'tkr_documento', value: cliente.documento);
    } else if (cliente is ClienteNatural) {
      await storage.write(key: 'tkr_name', value: cliente.nombre);
      await storage.write(key: 'tkr_last_name', value: cliente.apellidos);
      await storage.write(key: 'tkr_documento', value: cliente.documento);
    }
  }
}
