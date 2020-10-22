import 'package:flutter/material.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/enums/metodo_de_envio.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/ui/screens/direccion_screen.dart';
import 'package:mr_yupi/src/ui/screens/fin_pedido_screen.dart';
import 'package:mr_yupi/src/ui/screens/direcciones_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalizarPedidoScreen extends StatefulWidget {
  @override
  _FinalizarPedidoScreenState createState() => _FinalizarPedidoScreenState();
}

class _FinalizarPedidoScreenState extends State<FinalizarPedidoScreen> {
  Direccion _direccion;
  DireccionBloc _bloc;
  @override
  void initState() {
    _bloc = context.bloc<DireccionBloc>();
    loadDirecciones();
    super.initState();
  }

  loadDirecciones() {
    if (_bloc.state == null || !_bloc.state.hasData) {
      _bloc.initialLoad();
    } else {
      if (_bloc.state.data.items.length > 0) {
        setState(() {
          _direccion = _bloc.direccionDefault;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar pedido"),
      ),
      body: BlocListener<DireccionBloc, APIResponse<Paginate<Direccion>>>(
        cubit: _bloc,
        listener: (context, state) {
          if (!state.loading && state.hasData) {
            if (state.data.items.length > 0) {
              setState(() {
                _direccion = _bloc.direccionDefault;
              });
            }
          }
        },
        child: BlocBuilder<CarritoBloc, Pedido>(builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metodo de envio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RaisedButton(
                                color: (state.metodoDeEnvio == null ||
                                        state.metodoDeEnvio !=
                                            MetodoDeEnvio.A_DOMICILIO)
                                    ? Colors.white
                                    : null,
                                onPressed: _handleADomicilio,
                                child: Text("Envío a domicilio"),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: RaisedButton(
                                color: (state.metodoDeEnvio == null ||
                                        state.metodoDeEnvio !=
                                            MetodoDeEnvio.EN_TIENDA)
                                    ? Colors.white
                                    : null,
                                onPressed: _handleEnTienda,
                                child: Text("Recoger en almacén"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (MetodoDeEnvio.A_DOMICILIO == state.metodoDeEnvio)
                        _cardDireccion
                    ],
                  ),
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
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: _direccion != null ? _finalizarPedido : null,
                        child: Text(
                          "Finalizar pedido",
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
          );
        }),
      ),
    );
  }

  Widget get _cardDireccion {
    _direccion = _bloc.direccionDefault;
    if (_direccion == null) {
      return SizedBox(
        width: double.maxFinite,
        height: 200,
        child: Card(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: _handleAgregarDireccion,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Global.accentColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Agregar dirección"),
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: double.maxFinite,
      height: 200,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Cambiar",
                        style: TextStyle(
                          color: Global.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Global.accentColor,
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 12,
                    bottom: 12,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          "assets/direccion.png",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _direccion.descripcion,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _direccion.fullDireccion,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                _direccion.fullName,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _direccion.telefono,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _handleCambiarDireccion,
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleCambiarDireccion() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DireccionesScreen(
          picker: true,
        ),
      ),
    );
  }

  _handleAgregarDireccion() async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DireccionScreen(),
      ),
    );
    if (result != null && result) {
      _bloc.initialLoad();
    }
  }

  _finalizarPedido() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FinPedidoScreen(),
      ),
    );
  }

  _handleADomicilio() {
    context.bloc<CarritoBloc>().setMetodoDeEnvio(MetodoDeEnvio.A_DOMICILIO);
  }

  _handleEnTienda() {
    context.bloc<CarritoBloc>().setMetodoDeEnvio(MetodoDeEnvio.EN_TIENDA);
  }
}
