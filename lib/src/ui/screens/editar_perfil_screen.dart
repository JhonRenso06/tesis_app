import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/ui/screens/editar_password_screen.dart';
import 'package:mr_yupi/src/ui/widgets/loading_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditarPerfilScreen extends StatefulWidget {
  final Cliente cliente;

  EditarPerfilScreen(this.cliente);

  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  TipoDeDocumento _tipo;
  GlobalKey<FormState> _formKey;
  String _nombre, _apellidos, _email, _documento;

  Map<String, FocusNode> focusMap = {
    "documento": FocusNode(),
    "nombre": FocusNode(),
    "apellidos": FocusNode(),
    "guardar": FocusNode(),
  };

  @override
  void initState() {
    _tipo = widget.cliente.tipoDeDocumento;
    _formKey = GlobalKey();
    print(widget.cliente.toMap());
    super.initState();
  }

  @override
  void dispose() {
    this.focusMap.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget logoWidget = Container(
      height: 250.0,
      child: Image.asset(
        "assets/logo.png",
        fit: BoxFit.contain,
      ),
    );
    Widget tipoWidget = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField(
        items: [
          DropdownMenuItem(
            value: TipoDeDocumento.DNI,
            child: Text("Cliente natural"),
          ),
          DropdownMenuItem(
            value: TipoDeDocumento.RUC,
            child: Text("Cliente juridico"),
          )
        ],
        onChanged: (value) {
          setState(() {
            _tipo = value;
          });
          _formKey.currentState.reset();
        },
        value: _tipo,
      ),
    );

    Widget nombreField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["nombre"],
        onFieldSubmitted: (_) {
          if (_tipo == TipoDeDocumento.DNI) {
            FocusScope.of(context).requestFocus(focusMap["apellidos"]);
          } else {
            FocusScope.of(context).requestFocus(focusMap["guardar"]);
          }
        },
        decoration: InputDecoration(
          labelText: _tipo == TipoDeDocumento.DNI ? 'Nombre' : 'Razón social',
        ),
        textInputAction: _tipo == TipoDeDocumento.DNI
            ? TextInputAction.next
            : TextInputAction.done,
        keyboardType: TextInputType.text,
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese su ${_tipo == TipoDeDocumento.DNI ? 'nombre' : 'razón social'} ";
          }
          return null;
        },
        initialValue: () {
          if (widget.cliente is ClienteJuridico) {
            return (widget.cliente as ClienteJuridico).razonSocial;
          }
          if (widget.cliente is ClienteNatural) {
            return (widget.cliente as ClienteNatural).nombre;
          }
        }(),
        onSaved: (val) {
          _nombre = val;
        },
      ),
    );

    Widget apellidosField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Apellidos",
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: focusMap["apellidos"],
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["guardar"]),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese sus apellidos";
          }
          return null;
        },
        onSaved: (val) {
          _apellidos = val;
        },
        initialValue: () {
          if (widget.cliente is ClienteNatural) {
            return (widget.cliente as ClienteNatural).apellidos;
          }
        }(),
      ),
    );

    Widget documentoField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: false,
        maxLength: _tipo == TipoDeDocumento.DNI ? 8 : 11,
        textInputAction: TextInputAction.next,
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        focusNode: focusMap["documento"],
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["nombre"]),
        decoration: InputDecoration(
          hintText: _tipo == TipoDeDocumento.DNI ? "DNI" : "RUC",
          counterText: "",
        ),
        validator: (val) {
          if (_tipo == TipoDeDocumento.DNI) {
            if (val.length < 6) {
              return "Ingrese su DNI";
            }
          } else if (val.length < 11) {
            return "Ingrese su RUC";
          }
          return null;
        },
        onSaved: (val) {
          _documento = val;
        },
        initialValue: widget.cliente.documento,
      ),
    );

    Widget registerButton = SizedBox(
      width: double.maxFinite,
      child: RaisedButton(
        focusNode: focusMap["guardar"],
        onPressed: _onSave,
        child: Text("Guardar"),
      ),
    );
    Widget cambiarPasswordButton = Container(
        margin: const EdgeInsets.only(right: 6, top: 12),
        width: double.maxFinite,
        child: FlatButton(
            onPressed: _toChangePassword, child: Text("Cambiar contraseña")));

    List<Widget> form;
    if (_tipo == TipoDeDocumento.DNI) {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        apellidosField,
        registerButton,
        cambiarPasswordButton
      ];
    } else {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        registerButton,
        cambiarPasswordButton
      ];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Editar perfil",
      )),
      body: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: form,
                  ),
                ),
              ),
            ),
            BlocListener<PerfilBloc, APIResponse<Cliente>>(
              cubit: context.bloc<PerfilBloc>(),
              listener: (context, state) {
                if (!state.loading) {
                  if (state.hasMessage) {
                    _showSuccess(state.message);
                  } else if (state.hasException) {
                    Alert(
                      context: context,
                      title: "¡Uy!",
                      desc: state.exception.message,
                      type: AlertType.error,
                    ).show();
                  }
                }
              },
              child: SizedBox.shrink(),
            ),
            BlocBuilder<PerfilBloc, APIResponse>(
              cubit: context.bloc<PerfilBloc>(),
              builder: (context, state) {
                return state.loading ? LoadingWidget() : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  _onSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Cliente cliente;
      if (_tipo == TipoDeDocumento.DNI) {
        cliente = ClienteNatural(
          documento: _documento,
          nombre: _nombre,
          apellidos: _apellidos,
          correo: _email,
        );
      } else {
        cliente = ClienteJuridico(
          documento: _documento,
          razonSocial: _nombre,
          correo: _email,
        );
      }
      context.bloc<PerfilBloc>().updateMe(cliente);
    }
  }

  _showSuccess(APIMessage message) async {
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

  _toChangePassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditarPasswordScreen()));
  }
}
