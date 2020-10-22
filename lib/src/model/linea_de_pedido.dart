import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class LineaDePedido extends Model {
  num id;
  num precio;
  num cantidad;
  num subtotal;
  ProductoEstablecimiento productoEstablecimiento;

  LineaDePedido({
    this.id,
    this.precio,
    this.cantidad,
    this.subtotal,
    this.productoEstablecimiento,
  });

  num calcularSubTotal() {
    return cantidad * definirPrecio;
  }

  num get definirPrecio {
    return productoEstablecimiento.definirPrecio(cantidad);
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    precio = data["precio"] != null ? num.parse(data["precio"]) : 0;
    cantidad = data["cantidad"];
    subtotal = data["subtotal"] != null ? num.parse(data["subtotal"]) : 0;
    if (data["productoEstablecimiento"] != null) {
      productoEstablecimiento =
          ProductoEstablecimiento().fromMap(data["productoEstablecimiento"]);
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cantidad': cantidad,
    };
  }
}
