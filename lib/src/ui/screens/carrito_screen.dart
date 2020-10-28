import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/ui/screens/finalizar_pedido_screen.dart';
import 'package:mr_yupi/src/ui/screens/login_screen.dart';
import 'package:mr_yupi/src/ui/widgets/item_carrito_widget.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
      ),
      body: BlocBuilder<CarritoBloc, Pedido>(
        builder: (context, state) {
          if (state == null) {
            return Container();
          }
          if (state.lineasDePedido.length == 0) {
            return Center(
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
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    bottom: 20,
                    top: 7,
                  ),
                  itemCount: state.lineasDePedido.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCarritoWidget(state.lineasDePedido[index]);
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
                              "S/. ${state.calcularSubTotal().toStringAsFixed(2)}",
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
                              "S/. ${state.calcularIGV().toStringAsFixed(2)}",
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
                              "S/. ${state.calcularTotal().toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 8),
                    BlocBuilder<PerfilBloc, APIResponse<Cliente>>(
                      builder: (context, state) {
                        if (!state.hasData) {
                          return SizedBox(
                            width: double.maxFinite,
                            child: RaisedButton(
                              onPressed: () {
                                _handleIniciarSesion(context);
                              },
                              child: Text(
                                "Iniciar sesión",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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

  _handleIniciarSesion(BuildContext context) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
    if (result != null && result) {
      context.bloc<PerfilBloc>().getCurrentClient();
      _handleProcesarCompra(context);
    }
  }
}
