import 'package:mr_yupi/src/api/carrito_api.dart';
import 'package:mr_yupi/src/database/database.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/item_cart.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';

class CarritoRepository {
  CarritoAPI _carritoAPI;
  FlutterDatabase _database;

  CarritoRepository() {
    _carritoAPI = CarritoAPI();
  }

  _initDatabase() async {
    if (_database == null) {
      _database =
          await $FloorFlutterDatabase.databaseBuilder('yupi_chela.db').build();
    }
  }

  Future<List<LineaDePedido>> getCarrito(
      Establecimiento establecimiento) async {
    await _initDatabase();
    var items = await _database.itemCartDao.findItemsCart();
    List<num> ids = [];
    items.forEach((element) {
      ids.add(element.id);
    });
    if (ids.length == 0) {
      return List();
    }

    var result = await _carritoAPI.getCarrito(establecimiento, ids);

    if (!result.hasData) {
      return List();
    }
    List<LineaDePedido> lineasDePedido = [];
    result.data.items.forEach((element) {
      try {
        var item = items.firstWhere((item) => item.id == element.producto.id);
        LineaDePedido lineaDePedido = LineaDePedido(
          productoEstablecimiento: element,
          cantidad: item.cantidad,
        );
        lineasDePedido.add(lineaDePedido);
      } catch (_) {}
    });
    return lineasDePedido;
  }

  addCarrito(LineaDePedido lineaDePedido) async {
    await _initDatabase();
    var id = lineaDePedido.productoEstablecimiento.producto.id;
    var cantidad = lineaDePedido.cantidad;
    ItemCart itemCart = await _database.itemCartDao.findItemCartById(id);
    if (itemCart != null) {
      await _database.itemCartDao.updateItemCart(ItemCart(id, cantidad));
    } else {
      await _database.itemCartDao.insertItemCart(ItemCart(id, cantidad));
    }
  }

  removeCarrito(LineaDePedido lineaDePedido) async {
    await _initDatabase();
    var id = lineaDePedido.productoEstablecimiento.producto.id;
    await _database.itemCartDao.deleteItemCart(id);
  }
}
