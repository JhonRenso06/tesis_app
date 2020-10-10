import 'package:flutter/material.dart';
import 'package:mr_yupi/src/ui/screens/finalizar_pedido_screen.dart';
import 'package:provider/provider.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/ui/widgets/item_carrito_widget.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var carritoProvider = Provider.of<CarritoProvider>(context);
    if (carritoProvider.cantidad == 0) {
      double width = MediaQuery.of(context).size.width * 0.4;
      return Scaffold(
        appBar: AppBar(
          title: Text("Carrito"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.18),
                child: Image.asset(
                  "assets/empty-cart.png",
                  height: width,
                  width: width,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Tu carrito esta vacío",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }
    List<LineaDePedido> lineasDePedido = carritoProvider.lineasDePedido;
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                bottom: 20,
                top: 7,
              ),
              itemCount: lineasDePedido.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCarritoWidget(lineasDePedido[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
              left: 24,
              right: 24,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Subtotal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "S/. ${carritoProvider.subTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "IGV",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "S/. ${carritoProvider.igv.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "S/. ${carritoProvider.total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _handleProcesarCompra(context);
                    },
                    child: Text(
                      "Procesar pedido",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _handleProcesarCompra(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FinalizarPedidoScreen(),
      ),
    );
  }
}
