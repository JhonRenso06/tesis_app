import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/producto.dart';

class ProductoEstablecimiento extends Model {
  num id;
  num stock;
  Producto producto;

  ProductoEstablecimiento({
    this.id,
    this.stock,
    this.producto,
  });

  num definirPrecio(int cantidad) {
    return producto.definirPrecio(cantidad).monto;
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.stock = data["stock"];
    if (data["producto"] != null) {
      this.producto = Producto().fromMap(data["producto"]);
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stock': stock,
      'producto': producto.toMap(),
    };
  }
}
