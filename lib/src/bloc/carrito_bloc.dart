import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/enums/metodo_de_envio.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/resources/carrito_repository.dart';

class CarritoBloc extends Cubit<Pedido> {
  CarritoRepository _repository;

  CarritoBloc() : super(null) {
    _repository = CarritoRepository();
  }

  getCarrito(Establecimiento establecimiento) async {
    var result = await _repository.getCarrito(establecimiento);
    emit(Pedido(lineasDePedido: result));
  }

  get count {
    if (state == null) {
      return 0;
    }
    return state.lineasDePedido.length;
  }

  addLineaDePedido(
      ProductoEstablecimiento productoEstablecimiento, int cantidad) async {
    if (state == null) {
      return;
    }
    LineaDePedido lineaDePedido;
    try {
      lineaDePedido = state.lineasDePedido.firstWhere(
        (element) =>
            (element.productoEstablecimiento.id == productoEstablecimiento.id),
      );
    } catch (_) {}

    if (lineaDePedido == null) {
      lineaDePedido =
          LineaDePedido(productoEstablecimiento: productoEstablecimiento);
      state.lineasDePedido.add(lineaDePedido);
    }
    lineaDePedido.cantidad = cantidad;

    await _repository.addCarrito(lineaDePedido);

    emit(Pedido(lineasDePedido: state.lineasDePedido));
  }

  deleteLineaDePedido(LineaDePedido lineaDePedido) async {
    if (state == null) {
      return;
    }

    await _repository.removeCarrito(lineaDePedido);
    print(lineaDePedido.productoEstablecimiento.id);

    var result = state.lineasDePedido
        .where((element) =>
            element.productoEstablecimiento.id !=
            lineaDePedido.productoEstablecimiento.id)
        .toList();

    emit(Pedido(lineasDePedido: result));
  }

  setMetodoDeEnvio(MetodoDeEnvio metodo) {
    emit(Pedido(
      lineasDePedido: state.lineasDePedido,
      metodoDeEnvio: metodo,
    ));
  }

  clear() async {
    await _repository.clear();
    emit(Pedido());
  }
}
