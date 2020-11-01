import 'package:flutter/material.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/delivery_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/enums/documento_comercial.dart';
import 'package:mr_yupi/src/enums/metodo_de_envio.dart';
import 'package:mr_yupi/src/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:mr_yupi/src/model/delivery.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/ui/screens/direccion_screen.dart';
import 'package:mr_yupi/src/ui/screens/fin_pedido_screen.dart';
import 'package:mr_yupi/src/ui/screens/direcciones_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalizarPedidoScreen extends StatefulWidget {
  @override
  _FinalizarPedidoScreenState createState() => _FinalizarPedidoScreenState();
}

class _FinalizarPedidoScreenState extends State<FinalizarPedidoScreen> {
  DireccionBloc _bloc;
  DeliveryBloc _delivery;
  CarritoBloc _carrito;
  EstablecimientoBloc _establecimiento;
  Map<String, FocusNode> focusMap = {
    "nombre": FocusNode(),
    "dni": FocusNode(),
    "direccion": FocusNode(),
  };
  GlobalKey<FormState> form = GlobalKey();

  @override
  void initState() {
    _bloc = context.bloc<DireccionBloc>();
    _delivery = DeliveryBloc();
    loadDirecciones();
    super.initState();
  }

  @override
  void dispose() {
    this.focusMap.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  loadDirecciones() {
    _carrito = context.bloc<CarritoBloc>();
    _establecimiento = context.bloc<EstablecimientoBloc>();
    context.bloc<CarritoBloc>().state.direccion = null;
    context.bloc<CarritoBloc>().state.metodoDeEnvio = null;
    if (_bloc.state == null || !_bloc.state.hasData) {
      _bloc.initialLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar pedido"),
      ),
      body: BlocListener<CarritoBloc, Pedido>(
        listener: (context, state) {
          if (_bloc.direccionDefault != null &&
              _establecimiento.state != null) {
            _delivery.getDelivery(
                _establecimiento.state, _bloc.direccionDefault);
          }
        },
        child: BlocListener<DireccionBloc, APIResponse<Paginate<Direccion>>>(
          listener: (context, state) {
            if (!state.loading &&
                _bloc.direccionDefault != null &&
                _establecimiento.state != null) {
              _delivery.getDelivery(
                  _establecimiento.state, _bloc.direccionDefault);
            }
          },
          child: BlocBuilder<CarritoBloc, Pedido>(builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Método de envío",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 12),
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
                              if (MetodoDeEnvio.A_DOMICILIO ==
                                  state.metodoDeEnvio)
                                BlocBuilder<DireccionBloc,
                                    APIResponse<Paginate<Direccion>>>(
                                  builder: (context, state) {
                                    return _cardDireccion;
                                  },
                                )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Método de pago",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RaisedButton(
                                        color: (state.metodoDePago == null ||
                                                state.metodoDePago !=
                                                    MetodoDePago.EFECTIVO)
                                            ? Colors.white
                                            : null,
                                        onPressed: _handleContraentrega,
                                        child: Text("Contra entrega"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: RaisedButton(
                                        color: (state.metodoDePago == null ||
                                                state.metodoDePago !=
                                                    MetodoDePago.TRANSFERENCIA)
                                            ? Colors.white
                                            : null,
                                        onPressed: _handleTransferencia,
                                        child: Text("Transferencia bancaria"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Documento",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RaisedButton(
                                        color: (state.documentoComercial ==
                                                    null ||
                                                state.documentoComercial !=
                                                    DocumentoComercial.BOLETA)
                                            ? Colors.white
                                            : null,
                                        onPressed: _handleBoleta,
                                        child: Text("Boleta"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: RaisedButton(
                                        color: (state.documentoComercial ==
                                                    null ||
                                                state.documentoComercial !=
                                                    DocumentoComercial.FACTURA)
                                            ? Colors.white
                                            : null,
                                        onPressed: _handleFactura,
                                        child: Text("Factura"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              formDocumento(),
                            ],
                          ),
                        ),
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
                          BlocBuilder<CarritoBloc, Pedido>(
                            builder: (context, state) {
                              if (state.metodoDeEnvio ==
                                  MetodoDeEnvio.A_DOMICILIO) {
                                return Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Costo de envío",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        BlocBuilder<DeliveryBloc,
                                            APIResponse<Delivery>>(
                                          cubit: _delivery,
                                          builder: (context, state) {
                                            if (state.loading) {
                                              return SizedBox(
                                                height: 18,
                                                width: 18,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (!state.hasData ||
                                                state.data.monto == null ||
                                                state.data.monto == 0) {
                                              return Text(
                                                "No disponible",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              );
                                            }
                                            return Text(
                                              "S/. ${state.data.monto.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    )
                                  ],
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
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
                      BlocBuilder<DeliveryBloc, APIResponse<Delivery>>(
                          cubit: _delivery,
                          builder: (context, stateDelivery) {
                            return BlocBuilder<DireccionBloc,
                                    APIResponse<Paginate<Direccion>>>(
                                builder: (context, _) {
                              return SizedBox(
                                width: double.maxFinite,
                                child: RaisedButton(
                                  onPressed: ((_bloc.direccionDefault != null &&
                                                  state.metodoDeEnvio ==
                                                      MetodoDeEnvio
                                                          .A_DOMICILIO &&
                                                  stateDelivery.hasData &&
                                                  stateDelivery.data.monto >
                                                      0) ||
                                              (state.metodoDeEnvio ==
                                                  MetodoDeEnvio.EN_TIENDA)) &&
                                          state.metodoDePago != null &&
                                          state.documentoComercial != null
                                      ? _finalizarPedido
                                      : null,
                                  child: Text(
                                    "Finalizar pedido",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget get _cardDireccion {
    Direccion _direccion = _bloc.direccionDefault;
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
    if (!form.currentState.validate()) {
      return;
    }
    var _carrito = context.bloc<CarritoBloc>();
    if (_carrito.state.metodoDeEnvio == MetodoDeEnvio.A_DOMICILIO) {
      _carrito.state.direccion = _bloc.direccionDefault;
    } else {
      _carrito.state.direccion = null;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FinPedidoScreen(),
      ),
    );
  }

  _handleADomicilio() {
    context.bloc<CarritoBloc>().setMetodoDeEnvio(
          MetodoDeEnvio.A_DOMICILIO,
        );
  }

  _handleEnTienda() {
    context.bloc<CarritoBloc>().setMetodoDeEnvio(MetodoDeEnvio.EN_TIENDA);
  }

  _handleBoleta() {
    context.bloc<CarritoBloc>().setDocumento(DocumentoComercial.BOLETA);
  }

  _handleFactura() {
    context.bloc<CarritoBloc>().setDocumento(DocumentoComercial.FACTURA);
  }

  _handleContraentrega() {
    context.bloc<CarritoBloc>().setMetodoDePago(MetodoDePago.EFECTIVO);
  }

  _handleTransferencia() {
    context.bloc<CarritoBloc>().setMetodoDePago(MetodoDePago.TRANSFERENCIA);
  }

  Widget formDocumento() {
    var documento = context.bloc<CarritoBloc>().state.documentoComercial;
    var cliente = context.bloc<PerfilBloc>().state.data;
    if (documento == DocumentoComercial.BOLETA) {
      String nombre = "";
      String dni = "";
      if (cliente is ClienteNatural) {
        nombre = cliente.fullName;
        dni = cliente.documento;
      }
      Widget nombreApellidosField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          key: Key("nombre"),
          focusNode: focusMap["nombre"],
          initialValue: nombre,
          decoration: InputDecoration(
            labelText: 'Nombre y apellidos',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(focusMap["dni"]),
          validator: (val) {
            if (val.isEmpty) {
              return "Ingrese su nombre y apellidos";
            }
            return null;
          },
          onSaved: (val) {},
        ),
      );

      Widget dniField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          key: Key("dni"),
          focusNode: focusMap["dni"],
          initialValue: dni,
          decoration: InputDecoration(
            labelText: 'DNI',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val.isEmpty) {
              return "Ingrese su DNI";
            }
            return null;
          },
          onSaved: (val) {},
        ),
      );

      return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nombreApellidosField,
                dniField,
              ],
            ),
          ));
    }
    if (documento == DocumentoComercial.FACTURA) {
      String razonSocial = "";
      String ruc = "";

      Direccion dir = context.bloc<DireccionBloc>().direccionDefault;
      String direccion = dir?.descripcion ?? "";

      if (cliente is ClienteJuridico) {
        razonSocial = cliente.fullName;
        ruc = cliente.documento;
      }

      Widget razonSocialField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          key: Key("razonSocial"),
          focusNode: focusMap["nombre"],
          initialValue: razonSocial,
          decoration: InputDecoration(
            labelText: 'Razón social',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(focusMap["dni"]),
          validator: (val) {
            if (val.isEmpty) {
              return "Ingrese su razón social";
            }
            return null;
          },
          onSaved: (val) {},
        ),
      );

      Widget rucField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          key: Key("ruc"),
          focusNode: focusMap["dni"],
          initialValue: ruc,
          decoration: InputDecoration(
            labelText: 'RUC',
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(focusMap["dirección"]),
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val.isEmpty) {
              return "Ingrese su RUC";
            }
            return null;
          },
          onSaved: (val) {},
        ),
      );

      Widget direccionField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          key: Key("direccion"),
          focusNode: focusMap["direccion"],
          initialValue: direccion,
          decoration: InputDecoration(
            labelText: 'Dirección fiscal',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val.isEmpty) {
              return "Ingrese su dirección fiscal";
            }
            return null;
          },
          onSaved: (val) {},
        ),
      );
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [razonSocialField, rucField, direccionField],
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }
}
