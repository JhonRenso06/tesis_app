import 'package:mr_yupi/src/enums/moneda.dart';
import 'package:mr_yupi/src/enums/tipo_de_producto.dart';
import 'package:mr_yupi/src/model/caracteristica.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/precio.dart';
import 'package:mr_yupi/src/model/unidad_de_medida.dart';

class Producto extends Model {
  num id;
  TipoDeProducto tipo;
  bool exonerado;
  bool favorito;
  String nombre;
  String descripcion;
  Moneda moneda;
  num pesoTotal;
  num descuento;
  List<Precio> precios;
  List<String> fotos;
  UnidadDeMedida unidadDeMedida;
  Categoria categoria;
  List<Caracteristica> caracteristicas;

  Producto({
    this.id,
    this.tipo,
    this.exonerado,
    this.nombre,
    this.descripcion,
    this.moneda,
    this.pesoTotal,
    this.precios,
    this.fotos,
    this.unidadDeMedida,
    this.categoria,
    this.caracteristicas,
    this.favorito = false,
  });

  Precio definirPrecio(int cantidad) {
    for (Precio precio in precios) {
      if (cantidad >= precio.cantidad) {
        return precio;
      }
    }
    return precios[0];
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    tipo = TipoDeProductoExtension.parse(data["tipo"]);
    exonerado = data["exonerado"];
    nombre = data["nombre"];
    descripcion = data["descripcion"] ?? "";
    Moneda.values.forEach((element) {
      if (data["moneda"] == element.index) {
        moneda = element;
      }
    });
    pesoTotal = data["pesoTotal"];
    precios = List();
    if (data["precios"] != null) {
      (data["precios"] as List).forEach((element) {
        precios.add(Precio().fromMap(element));
      });
      precios.sort((b, a) => a.cantidad.compareTo(b.cantidad));
    }
    fotos = List();
    (data["fotos"] as List).forEach((element) {
      fotos.add(element);
    });

    if (data["unidadDeMedida"] != null) {
      unidadDeMedida = UnidadDeMedida().fromMap(data["unidadDeMedida"]);
    }
    if (data["categoria"] != null) {
      categoria = Categoria().fromMap(data["categoria"]);
    }
    if (data["caracteristicas"] != null) {
      (data["caracteristicas"] as List).forEach((element) {
        caracteristicas.add(Caracteristica().fromMap(element));
      });
    }
    favorito = false;
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'exonerado': exonerado,
      'nombre': nombre,
      'descripcion': descripcion,
      'moneda': moneda?.index,
      'pesoTotal': pesoTotal,
      'unidadDeMedida': unidadDeMedida?.id,
      'categoria': categoria?.id,
    };
  }

  get foto {
    if (fotos.length > 0) {
      return fotos[0];
    } else {
      return null;
    }
  }
}
