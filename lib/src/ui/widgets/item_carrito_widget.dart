import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCarritoWidget extends StatefulWidget {
  final LineaDePedido lineaDePedido;
  final double height;
  ItemCarritoWidget(this.lineaDePedido, {this.height = 180});
  @override
  State<StatefulWidget> createState() => _ItemCarritoWidget();
}

class _ItemCarritoWidget extends State<ItemCarritoWidget> {
  TextEditingController _controller = new TextEditingController();

  initState() {
    super.initState();
    _controller.value = _controller.value
        .copyWith(text: widget.lineaDePedido.cantidad.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductoEstablecimiento productoEstablecimiento =
        widget.lineaDePedido.productoEstablecimiento;
    LineaDePedido lineaDePedido = widget.lineaDePedido;
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8, bottom: 4),
                      child: Text(
                        productoEstablecimiento.producto.nombre,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: const EdgeInsets.only(top: 4),
                      iconSize: 24,
                      icon: Icon(
                        Icons.close,
                        color: Global.accentColor,
                      ),
                      onPressed: _handleDelete,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 6),
                child: Divider(),
              ),
              Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.4,
                    height: widget.height,
                    child: productoEstablecimiento.producto.foto != null
                        ? CachedNetworkImage(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            imageUrl:
                                productoEstablecimiento.producto.foto ?? "",
                            fit: BoxFit.contain,
                            placeholder: (context, _) => Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[300],
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Center(
                            child: Image.asset("assets/products.png"),
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    width: constraints.maxWidth * 0.6,
                    height: widget.height,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Precio",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (productoEstablecimiento
                                            .producto.descuento !=
                                        null &&
                                    productoEstablecimiento.producto.descuento >
                                        0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "S/" +
                                            productoEstablecimiento
                                                .producto.precios[0].monto
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontFamily: "Quicksand",
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        " - ${productoEstablecimiento.producto.descuento.toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    "S/. ${lineaDePedido.definirPrecio.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            if (productoEstablecimiento.producto.descuento !=
                                    null &&
                                productoEstablecimiento.producto.descuento > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Oferta",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "S/. ${productoEstablecimiento.producto.descuento.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Subtotal",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${lineaDePedido.calcularSubTotal().toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double width = constraints.maxWidth / 3;
                                return SizedBox(
                                  height: 48,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width,
                                        child: OutlineButton(
                                          onPressed: _handleLess,
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              textDirection: TextDirection.ltr,
                                              color: Colors.black,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: TextField(
                                          controller: _controller,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                            decimal: false,
                                            signed: false,
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onSubmitted: _handleSubmit,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              borderSide: BorderSide(
                                                color: Global.accentColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              borderSide: BorderSide(
                                                color: Global.primaryColorDark,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: OutlineButton(
                                          onPressed: _handlePlus,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              textDirection: TextDirection.ltr,
                                              color: Colors.black,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _handleLess() {
    int cantidad = int.parse(_controller.value.text);
    if (cantidad > 1) {
      cantidad--;
      _controller.value = _controller.value.copyWith(text: cantidad.toString());
      context.bloc<CarritoBloc>().addLineaDePedido(
          widget.lineaDePedido.productoEstablecimiento, cantidad);
    }
  }

  _handlePlus() {
    int cantidad = int.parse(_controller.value.text);
    if (cantidad < widget.lineaDePedido.productoEstablecimiento.stock) {
      cantidad++;
      _controller.value = _controller.value.copyWith(text: cantidad.toString());
      context.bloc<CarritoBloc>().addLineaDePedido(
          widget.lineaDePedido.productoEstablecimiento, cantidad);
    }
  }

  _handleSubmit(str) {
    int cantidad;
    if (str == "") {
      cantidad = 0;
    } else {
      cantidad = int.parse(str);
    }
    if (cantidad > 0 &&
        cantidad < widget.lineaDePedido.productoEstablecimiento.stock) {
      context.bloc<CarritoBloc>().addLineaDePedido(
          widget.lineaDePedido.productoEstablecimiento, cantidad);
    } else {
      _controller.value = _controller.value
          .copyWith(text: widget.lineaDePedido.cantidad.toString());
    }
  }

  _handleDelete() {
    context.bloc<CarritoBloc>().deleteLineaDePedido(widget.lineaDePedido);
  }
}
