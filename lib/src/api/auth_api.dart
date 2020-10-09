import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/auth_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:mr_yupi/src/model/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/token_data.dart';

class AuthAPI extends API {
  AuthAPI() : super('/auth/clientes');

  login(Cliente cliente) async {
    Map<String, dynamic> body = {
      'correo': cliente.correo,
      'password': cliente.password
    };
    var result = await post('/signin', body: body);
    var response = AuthResponse.fromMap(result);
    _saveToken(response.token);
    return response.message;
  }

  register(Cliente cliente) async {
    Map<String, dynamic> body = {};
    body['documento'] = cliente.documento;
    body['tipoDeDocumento'] = cliente.documento.length == 8
        ? TipoDeDocumento.DNI.index
        : TipoDeDocumento.RUC.index;

    if (cliente is ClienteNatural) {
      body['nombre'] = cliente.nombre;
      body['apellidos'] = cliente.apellidos;
    } else if (cliente is ClienteJuridico) {
      body['nombre'] = cliente.razonSocial;
    }
    body['correo'] = cliente.correo;
    body['password'] = cliente.password;
    var result = await post('/signup', body: body);
    var response = AuthResponse.fromMap(result);
    _saveToken(response.token);
    return response.message;
  }

  Future<Cliente> getCurrrentClient() async {
    Map<String, String> data = await storage.readAll();
    if (data['tkr_access_token'] == null) {
      return null;
    }
    String documento = data['tkr_documento'];
    if (documento.length == 11) {
      return ClienteJuridico(
        correo: data['tkr_email'],
        documento: documento,
        razonSocial: data['tkr_name'],
      );
    } else {
      return ClienteNatural(
        correo: data['tkr_email'],
        documento: documento,
        nombre: data['tkr_name'],
        apellidos: data['tkr_last_name'],
      );
    }
  }

  Future<void> signOut() async {
    await storage.deleteAll();
  }

  Future<void> _saveToken(TokenData tokenData) async {
    await storage.write(key: 'tkr_status', value: tokenData.status.toString());
    await storage.write(key: 'tkr_email', value: tokenData.email);
    await storage.write(key: 'tkr_name', value: tokenData.name);
    await storage.write(key: 'tkr_last_name', value: tokenData.lastName);
    await storage.write(key: 'tkr_documento', value: tokenData.documento);
    await storage.write(key: 'tkr_access_token', value: tokenData.accessToken);
  }
}
