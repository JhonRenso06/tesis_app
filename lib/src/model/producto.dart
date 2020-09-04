import 'package:tesis_app/src/model/caracteristicas.dart';
import 'package:tesis_app/src/model/categoria.dart';
import 'package:tesis_app/src/model/enums/moneda.dart';
import 'package:tesis_app/src/model/enums/tipo_de_producto.dart';

class Producto {
  Categoria categoria;
  String codigoDeBarras, nombre, descripcion;
  List<String> fotos;
  List<Caracteristicas> caracteristicas;
  TipoDeProducto tipo;
  bool exonerado;
  num id, precio, descuento, peso, medida;
  Moneda moneda;

  Producto(
      {this.id,
      this.categoria,
      this.codigoDeBarras,
      this.nombre,
      this.descripcion,
      this.caracteristicas,
      this.fotos,
      this.tipo,
      this.exonerado,
      this.precio,
      this.descuento,
      this.peso,
      this.medida,
      this.moneda});

  Producto.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.categoria = Categoria.fromMap(data["categoria"]);
    this.codigoDeBarras = data["codigoDeBarras"];
    this.nombre = data["nombre"];
    this.descripcion = data["descripcion"];
    this.fotos = data["fotos"];
    this.caracteristicas = data["caracteristicas"];
    switch (data["tipo"]) {
      case "PRODUCTO":
        this.tipo = TipoDeProducto.PRODUCTO;
        break;

      case "SERVICIO":
        this.tipo = TipoDeProducto.SERVICIO;
        break;

      default:
        this.tipo = TipoDeProducto.PRODUCTO;
    }
    this.exonerado = data["exonerado"];
    this.precio = data["precio"];
    this.descuento = data["descuento"];
    this.peso = data["peso"];
    this.medida = data["medida"];
    switch (data["moneda"]) {
      case "SOLES":
        this.moneda = Moneda.SOLES;
        break;
      case "DOLARES":
        this.moneda = Moneda.DOLARES;
        break;
      default:
        this.moneda = Moneda.SOLES;
        break;
    }
  }

  num get precioDescuento => this.precio - (this.precio * this.descuento);
  String get porcentajeDescuento => "-${(this.descuento * 100).toInt()}%";
  String get precioDescuentoToFixed => precioDescuento.toStringAsFixed(2);
  String get precioToFixed => this.precio.toStringAsFixed(2);
}
