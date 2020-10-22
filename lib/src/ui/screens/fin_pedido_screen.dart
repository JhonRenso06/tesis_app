import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/finalizar_pedido_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto.dart';

class FinPedidoScreen extends StatefulWidget {
  @override
  _FinPedidoScreenState createState() => _FinPedidoScreenState();
}

class _FinPedidoScreenState extends State<FinPedidoScreen> {
  FinalizarPedidoBloc _bloc;

  @override
  void initState() {
    _bloc = FinalizarPedidoBloc();
    Direccion direccion = context.bloc<DireccionBloc>().direccionDefault;
    Pedido pedido = context.bloc<CarritoBloc>().state;
    Establecimiento establecimiento = context.bloc<EstablecimientoBloc>().state;
    pedido.direccion = direccion;
    _bloc.crearPedido(establecimiento, pedido);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.bottomCenter,
          //     colors: [
          //       Colors.white,
          //       Global.primarySwatch[50],
          //     ],
          //   ),
          // ),
          child: BlocBuilder<FinalizarPedidoBloc, APIResponse<Pedido>>(
              cubit: _bloc,
              builder: (context, state) {
                if (state.loading)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Procesando compra",
                            style: TextStyle(
                              color: Global.accentColor,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  );
                if (state.hasMessage)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Gracias por tu compra",
                            style: TextStyle(
                              color: Global.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.message?.message ?? "",
                            style: TextStyle(
                              color: Global.accentColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RaisedButton(
                            child: Text('Seguir comprando'),
                            onPressed: _success,
                          )
                        ],
                      )
                    ],
                  );

                if (state.hasException) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250.0,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Error",
                            style: TextStyle(
                              color: Global.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.exception?.message ?? "Intente mas tarde",
                            style: TextStyle(
                              color: Global.accentColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RaisedButton(
                            child: Text('Regresar a comprar'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 250.0,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        RaisedButton(
                          child: Text('Regresar a comprar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  _success() async {
    await context.bloc<CarritoBloc>().clear();
    Establecimiento establecimiento = context.bloc<EstablecimientoBloc>().state;
    context.bloc<ProductosBloc>().initialLoad(establecimiento);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
