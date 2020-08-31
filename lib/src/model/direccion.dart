import 'package:tesis_app/src/model/cliente.dart';
import 'package:tesis_app/src/model/departamento.dart';
import 'package:tesis_app/src/model/distrito.dart';
import 'package:tesis_app/src/model/provincia.dart';

enum TipoDireccion {
  CASA,
  DEPARTAMENTO,
  CONDOMINIO,
  RESIDENCIAL,
  OFICINA,
  LOCAL,
  CENTRO,
  MERCADO,
  GALERIA
}

class Direccion {
  num id;
  Departamento departamento;
  Provincia provincia;
  Distrito distrito;
  Cliente cliente;
  String nombre,
      apellidos,
      celular,
      telefono,
      direccion,
      urbanizacion,
      referencia;
  TipoDireccion tipo;
  num latitud, longitud, numeroDeLote, departamentoOInterior;
  bool predeterminado;

  Direccion.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.departamento = Departamento.fromMap(data["departamento"]);
    this.provincia = Provincia.fromMap(data["provincia"]);
    this.distrito = Distrito.fromMap(data["distrito"]);
    this.cliente = Cliente.fromMap(data["cliente"]);
    this.nombre = data["nombre"];
    this.apellidos = data["apellidos"];
    this.celular = data["celular"];
    this.nombre = data["nombre"];
    this.telefono = data["telefono"];
    this.direccion = data["direccion"];
    this.urbanizacion = data["urbanizacion"];
    this.referencia = data["referencia"];
    switch (data["tipo"]) {
      case 'CASA':
        this.tipo = TipoDireccion.CASA;
        break;
      case 'DEPARTAMENTO':
        this.tipo = TipoDireccion.DEPARTAMENTO;
        break;
      case 'CONDOMINIO':
        this.tipo = TipoDireccion.CONDOMINIO;
        break;
      case 'RESIDENCIAL':
        this.tipo = TipoDireccion.RESIDENCIAL;
        break;
      case 'OFICINA':
        this.tipo = TipoDireccion.OFICINA;
        break;
      case 'LOCAL':
        this.tipo = TipoDireccion.LOCAL;
        break;
      case 'CENTRO':
        this.tipo = TipoDireccion.CENTRO;
        break;
      case 'MERCADO':
        this.tipo = TipoDireccion.MERCADO;
        break;
      case 'GALERIA':
        this.tipo = TipoDireccion.GALERIA;
        break;
      default:
        this.tipo = TipoDireccion.CASA;
        break;
    }
    this.latitud = data["latitud"];
    this.longitud = data["longitud"];
    this.numeroDeLote = data["numeroDeLote"];
    this.departamentoOInterior = data["departamentoOInterior"];
    this.predeterminado = data["predeterminado"];
  }
}