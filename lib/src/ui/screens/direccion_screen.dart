import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/departamento_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/enums/tipo_de_direccion.dart';
import 'package:mr_yupi/src/model/api_exception.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/provincia.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DireccionScreen extends StatefulWidget {
  final Direccion direccion;
  DireccionScreen({this.direccion});
  @override
  _DireccionScreenState createState() => _DireccionScreenState();
}

class _DireccionScreenState extends State<DireccionScreen> {
  String _title, dropdownValue;
  Direccion _direccion;
  String _departamento;
  String _provincia;
  String _distrito;
  List<DropdownMenuItem<String>> _itemsDepartamento;
  List<DropdownMenuItem<String>> _itemsProvincias;
  List<DropdownMenuItem<String>> _itemsDistritos;
  List<Departamento> _departamentos;
  GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, FocusNode> focusMap = {
    "nombre": FocusNode(),
    "apellidos": FocusNode(),
    "celular": FocusNode(),
    "tipo": FocusNode(),
    "departamento": FocusNode(),
    "provincia": FocusNode(),
    "distrito": FocusNode(),
    "direccion": FocusNode(),
    "lote": FocusNode(),
    "int": FocusNode(),
    "urbanizacion": FocusNode(),
    "referencia": FocusNode(),
    "guardar": FocusNode(),
  };

  @override
  void initState() {
    if (widget.direccion == null) {
      _title = "Crear dirección";
      _direccion = Direccion(tipo: TipoDeDireccion.CASA);
    } else {
      _title = "Editar dirección";
      _direccion = widget.direccion;
    }
    _itemsDepartamento = [
      DropdownMenuItem(
        value: null,
        child: Text("Elige un departamento"),
      ),
    ];
    _itemsProvincias = [
      DropdownMenuItem(
        value: null,
        child: Text("Elige una provincia"),
      ),
    ];
    _itemsDistritos = [
      DropdownMenuItem(
        value: null,
        child: Text("Elige un distrito"),
      ),
    ];
    context.bloc<DepartamentoBloc>().getDepartamentos();
    super.initState();
  }

  @override
  void dispose() {
    this.focusMap.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  void loadDepartamento(List<Departamento> departamentos) {
    _departamentos = departamentos;
    _itemsDepartamento.addAll(
      _departamentos.map(
        (e) => DropdownMenuItem(
          child: Text(e.nombre),
          value: e.id,
        ),
      ),
    );
    if (widget.direccion != null) {
      _departamento = _direccion.distrito.provincia.departamento.id;
      _onChangeDepartamento(_departamento);
      _provincia = _direccion.distrito.provincia.id;
      _onChangeProvincia(_provincia);
      _distrito = _direccion.distrito.id;
    }
  }

  _onChangeDepartamento(String id) {
    try {
      Departamento departamento =
          _departamentos.firstWhere((element) => element.id == id);
      _itemsProvincias.clear();
      _itemsProvincias.add(
        DropdownMenuItem(
          value: null,
          child: Text("Elige una provincia"),
        ),
      );
      _itemsProvincias.addAll(
        departamento.provincias.map(
          (e) => DropdownMenuItem(
            child: Text(e.nombre),
            value: e.id,
          ),
        ),
      );
      _itemsDistritos.clear();
      _itemsDistritos.add(
        DropdownMenuItem(
          value: null,
          child: Text("Elige un distrito"),
        ),
      );
      _departamento = id;
      _provincia = null;
      _distrito = null;
      setState(() {});
    } catch (_) {
      _provincia = null;
      _distrito = null;
      setState(() {});
    }
    FocusScope.of(context).requestFocus(focusMap["provincia"]);
  }

  _onChangeProvincia(String id) {
    try {
      Departamento departamento =
          _departamentos.firstWhere((element) => element.id == _departamento);
      Provincia provincia =
          departamento.provincias.firstWhere((element) => element.id == id);
      _itemsDistritos.clear();
      _itemsDistritos.add(
        DropdownMenuItem(
          value: null,
          child: Text("Elige un distrito"),
        ),
      );
      _itemsDistritos.addAll(
        provincia.distritos.map(
          (e) => DropdownMenuItem(
            child: Text(e.nombre),
            value: e.id,
          ),
        ),
      );
      _provincia = id;
      _distrito = null;
      setState(() {});
    } catch (_) {
      _distrito = null;
    }
    FocusScope.of(context).requestFocus(focusMap["distrito"]);
  }

  @override
  Widget build(BuildContext context) {
    Widget nombreField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["nombre"],
        initialValue: widget.direccion?.nombre,
        decoration: InputDecoration(
          labelText: 'Nombre',
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["apellidos"]),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese su nombre";
          }
          return null;
        },
        onSaved: (val) {
          _direccion.nombre = val;
        },
      ),
    );

    Widget apellidosField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["apellidos"],
        initialValue: widget.direccion?.apellidos,
        decoration: InputDecoration(
          labelText: 'Apellidos',
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["celular"]),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese sus apellidos";
          }
          return null;
        },
        onSaved: (val) {
          _direccion.apellidos = val;
        },
      ),
    );

    Widget telefonoField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["celular"],
        initialValue: widget.direccion?.telefono,
        obscureText: false,
        maxLength: 9,
        textInputAction: TextInputAction.next,
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["tipo"]),
        decoration: InputDecoration(
          labelText: "Celular",
          counterText: "",
        ),
        validator: (val) {
          if (val.length != 9) {
            return "Ingrese un celular válido";
          }
          return null;
        },
        onSaved: (val) {
          _direccion.telefono = val;
        },
      ),
    );

    Widget tipoWidget = Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: DropdownButtonFormField(
        focusNode: focusMap["tipo"],
        items: [
          DropdownMenuItem(
            value: TipoDeDireccion.CASA,
            child: Text(TipoDeDireccion.CASA.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.CENTRO,
            child: Text(TipoDeDireccion.CENTRO.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.CONDOMINIO,
            child: Text(TipoDeDireccion.CONDOMINIO.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.DEPARTAMENTO,
            child: Text(TipoDeDireccion.DEPARTAMENTO.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.GALERIA,
            child: Text(TipoDeDireccion.GALERIA.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.LOCAL,
            child: Text(TipoDeDireccion.LOCAL.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.MERCADO,
            child: Text(TipoDeDireccion.MERCADO.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.OFICINA,
            child: Text(TipoDeDireccion.OFICINA.name),
          ),
          DropdownMenuItem(
            value: TipoDeDireccion.OTRO,
            child: Text(TipoDeDireccion.OTRO.name),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _direccion.tipo = value;
          });
          FocusScope.of(context).requestFocus(focusMap["departamento"]);
        },
        onSaved: (value) {
          _direccion.tipo = value;
        },
        value: _direccion.tipo,
        validator: (val) {
          return null;
        },
      ),
    );

    Widget departamentoWidget = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        focusNode: focusMap["departamento"],
        items: _itemsDepartamento,
        onChanged: _onChangeDepartamento,
        validator: (val) {
          if (val == null) {
            return "Seleccione un departamento";
          }
          return null;
        },
        onSaved: (value) {
          _departamento = value;
        },
        value: _departamento,
      ),
    );

    Widget provinciaWidget = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        focusNode: focusMap["provincia"],
        items: _itemsProvincias,
        onChanged: _onChangeProvincia,
        validator: (val) {
          if (val == null) {
            return "Seleccione una provincia";
          }
          return null;
        },
        onSaved: (value) {
          _provincia = value;
        },
        value: _provincia,
      ),
    );

    Widget distritoWidget = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        focusNode: focusMap["distrito"],
        items: _itemsDistritos,
        onChanged: (value) {
          setState(() {
            _distrito = value;
          });
          FocusScope.of(context).requestFocus(focusMap["direccion"]);
        },
        validator: (val) {
          if (val == null) {
            return "Seleccione un distrito";
          }
          return null;
        },
        onSaved: (value) {
          _distrito = value;
        },
        value: _distrito,
      ),
    );

    Widget direccionField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["direccion"],
        initialValue: widget.direccion?.descripcion,
        decoration: InputDecoration(
          labelText: "Dirección",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["lote"]),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese su dirección";
          }
          return null;
        },
        onSaved: (val) {
          _direccion.descripcion = val;
        },
      ),
    );

    Widget nLoteField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["lote"],
        initialValue: widget.direccion?.numeroDeLote,
        decoration: InputDecoration(
          labelText: "Nro/Lote",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["int"]),
        validator: (val) {
          if (val.isEmpty) {
            return "Campo requerido";
          }
          return null;
        },
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.numeroDeLote = val;
          }
        },
      ),
    );

    Widget dptoField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["int"],
        initialValue: widget.direccion?.departamentoOInterior,
        decoration: InputDecoration(
          labelText: "Dpto/Int (opcional)",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["urbanizacion"]),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.departamentoOInterior = val;
          }
        },
        validator: (_) => null,
      ),
    );

    Widget urbanizacionField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["urbanizacion"],
        initialValue: widget.direccion?.urbanizacion,
        decoration: InputDecoration(
          labelText: "Urbanización (opcional)",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["referencia"]),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.urbanizacion = val;
          }
        },
        validator: (_) => null,
      ),
    );

    Widget refereciaField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["referencia"],
        initialValue: widget.direccion?.referencia,
        decoration: InputDecoration(
          labelText: "Referencia (opcional)",
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["guardar"]),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.referencia = val;
          }
        },
        validator: (_) => null,
      ),
    );

    Widget buttonGuardar = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.maxFinite,
        child: RaisedButton(
          focusNode: focusMap["guardar"],
          child: Text("Guardar"),
          onPressed: _handleSave,
        ),
      ),
    );

    Widget buttonEliminar = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.maxFinite,
        child: FlatButton(
          child: Text("Eliminar"),
          onPressed: _handleEliminar,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<DepartamentoBloc, APIResponse<List<Departamento>>>(
          cubit: context.bloc<DepartamentoBloc>(),
          listener: (context, state) {
            if (state.hasData) {
              loadDepartamento(state.data);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 4,
                            bottom: 14,
                            top: 0,
                          ),
                          child: Text(
                            "Datos generales",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        nombreField,
                        apellidosField,
                        telefonoField,
                        tipoWidget,
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 4,
                            bottom: 14,
                            top: 0,
                          ),
                          child: Text(
                            "Datos de ubicación",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        departamentoWidget,
                        provinciaWidget,
                        distritoWidget,
                        direccionField,
                        nLoteField,
                        dptoField,
                        urbanizacionField,
                        refereciaField,
                      ],
                    ),
                  ),
                  BlocListener<DireccionBloc, APIResponse>(
                    cubit: context.bloc<DireccionBloc>(),
                    listener: (context, state) {
                      if (!state.loading) {
                        if (state.hasMessage) {
                          _onSuccess(state.message);
                        }
                        if (state.hasException) {
                          _onError(state.exception);
                        }
                      }
                    },
                    child: BlocBuilder<DireccionBloc, APIResponse>(
                      cubit: context.bloc<DireccionBloc>(),
                      builder: (context, state) {
                        if (state.loading) {
                          return CircularProgressIndicator();
                        } else {
                          if (widget.direccion != null) {
                            return Column(
                              children: [
                                buttonGuardar,
                                buttonEliminar,
                              ],
                            );
                          }
                          return buttonGuardar;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _direccion.distrito = Distrito(id: _distrito);
      if (widget.direccion != null) {
        context.bloc<DireccionBloc>().updateDireccion(_direccion);
      } else {
        context.bloc<DireccionBloc>().createDireccion(_direccion);
      }
    }
  }

  _onSuccess(APIMessage message) async {
    await Alert(
        context: context,
        title: "¡Genial!",
        desc: message.message,
        type: AlertType.success,
        closeFunction: () {
          print("Salio");
        },
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {Navigator.pop(context)},
          )
        ]).show();
    Navigator.pop(context, true);
  }

  _onError(APIException exception) {
    Alert(
      context: context,
      title: "Upss..",
      desc: exception.message,
      type: AlertType.error,
    ).show();
  }

  _handleEliminar() {
    context.bloc<DireccionBloc>().deleteDireccion(_direccion);
  }
}
