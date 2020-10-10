import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/provincia.dart';

class DireccionScreen extends StatefulWidget {
  final Direccion direccion;
  DireccionScreen({this.direccion});
  @override
  _DireccionScreenState createState() => _DireccionScreenState();
}

class _DireccionScreenState extends State<DireccionScreen> {
  String _title, dropdownValue;
  Direccion _direccion;
  int _departamento;
  int _provincia;
  int _distrito;
  List<DropdownMenuItem<int>> _itemsDepartamento;
  List<DropdownMenuItem<int>> _itemsProvincias;
  List<DropdownMenuItem<int>> _itemsDistritos;
  List<Departamento> _departamentos;
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    dropdownValue = "Casa";
    if (widget.direccion == null) {
      _title = "Crear dirección";
      _direccion = Direccion(tipo: TipoDireccion.CASA);
    } else {
      _title = "Editar dirección";
      _direccion = widget.direccion;
      _departamento = _direccion.distrito.provincia.departamento.id;
      _provincia = _direccion.distrito.provincia.id;
      _distrito = _direccion.distrito.id;
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
    loadDepartamento();
    super.initState();
  }

  void loadDepartamento() {
    _departamentos = [
      Departamento(
        id: 1,
        nombre: "La libertad",
        provincias: [
          Provincia(
            id: 1,
            nombre: "Trujillo",
            distritos: [
              Distrito(
                id: 1,
                nombre: "Trujillo",
              )
            ],
          )
        ],
      ),
      Departamento(
        id: 2,
        nombre: "Lima",
        provincias: [
          Provincia(
            id: 2,
            nombre: "Lima",
            distritos: [
              Distrito(
                id: 2,
                nombre: "Lima",
              )
            ],
          )
        ],
      )
    ];
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

  _onChangeDepartamento(int id) {
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
  }

  _onChangeProvincia(int id) {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget nombreField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre',
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
        decoration: InputDecoration(
          labelText: 'Apellidos',
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
        obscureText: false,
        maxLength: 9,
        textInputAction: TextInputAction.next,
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField(
        items: [
          DropdownMenuItem(
            value: TipoDireccion.CASA,
            child: Text("Casa"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.CENTRO,
            child: Text("Centro"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.CONDOMINIO,
            child: Text("Condominio"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.DEPARTAMENTO,
            child: Text("Departamento"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.GALERIA,
            child: Text("Galeria"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.LOCAL,
            child: Text("Local"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.MERCADO,
            child: Text("Mercado"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.OFICINA,
            child: Text("Oficina"),
          ),
          DropdownMenuItem(
            value: TipoDireccion.OTRO,
            child: Text("Otro"),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _direccion.tipo = value;
          });
        },
        onSaved: (value) {
          _direccion.tipo = value;
        },
        value: _direccion.tipo,
      ),
    );

    Widget departamentoWidget = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<int>(
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
      child: DropdownButtonFormField<int>(
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
      child: DropdownButtonFormField<int>(
        items: _itemsDistritos,
        onChanged: (value) {
          setState(() {
            _distrito = value;
          });
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
        decoration: InputDecoration(
          labelText: "Dirección",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese su dirección";
          }
          return null;
        },
        onSaved: (val) {
          _direccion.direccion = val;
        },
      ),
    );

    Widget nLoteField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Nro/Lote",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
        decoration: InputDecoration(
          labelText: "Dpto/Int (opcional)",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.departamentoOInterior = val;
          }
        },
      ),
    );

    Widget urbanizacionField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Urbanización (opcional)",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.urbanizacion = val;
          }
        },
      ),
    );

    Widget refereciaField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Referencia (opcional)",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        onSaved: (val) {
          if (val.isNotEmpty) {
            _direccion.referencia = val;
          }
        },
      ),
    );

    Widget buttonGuardar = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.maxFinite,
        child: RaisedButton(
          child: Text("Guardar"),
          onPressed: _handleSave,
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
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nombreField,
                  apellidosField,
                  telefonoField,
                  tipoWidget,
                  departamentoWidget,
                  provinciaWidget,
                  distritoWidget,
                  direccionField,
                  nLoteField,
                  dptoField,
                  urbanizacionField,
                  refereciaField,
                  buttonGuardar
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
    }
  }
}
