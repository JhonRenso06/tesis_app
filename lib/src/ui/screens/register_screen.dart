import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:mr_yupi/src/ui/widgets/loading_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey;
  String _nombre, _apellidos, _email, _password, _documento;
  bool _loading, _obscurePassword, _obscureRepeatPassword;
  TipoDeDocumento _tipo;
  PerfilBloc _bloc;

  @override
  void initState() {
    _formKey = GlobalKey();
    _loading = false;
    _obscurePassword = true;
    _obscureRepeatPassword = true;
    _tipo = TipoDeDocumento.DNI;
    _bloc = PerfilBloc();
    super.initState();
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
        decoration: InputDecoration(
          labelText: _tipo == TipoDeDocumento.DNI ? 'Nombre' : 'Razón social',
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        validator: (val) {
          if (val.isEmpty) {
            return "Ingrese su ${_tipo == TipoDeDocumento.DNI ? 'nombre' : 'razón social'} ";
          }
          return null;
        },
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
          _apellidos = val;
        },
      ),
    );

    Widget emailField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: false,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          labelText: "Email",
        ),
        validator: (val) {
          if (val.isEmpty || !EmailValidator.validate(val)) {
            return "Ingrese un email";
          }
          return null;
        },
        onSaved: (val) {
          _email = val;
        },
      ),
    );

    Widget passwordField = Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
            FocusScope.of(context).nextFocus();
          },
          decoration: InputDecoration(
            labelText: "Contraseña",
            suffixIcon: Container(
              width: 16,
              height: 16,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                iconSize: 16,
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Global.primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          validator: (val) {
            if (val.length < 6) {
              return "Ingrese una contraseña valida";
            }
            return null;
          },
          onSaved: (val) {
            _password = val;
          },
        ));

    Widget documentoField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: false,
        maxLength: _tipo == TipoDeDocumento.DNI ? 8 : 11,
        textInputAction: TextInputAction.next,
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          labelText: _tipo == TipoDeDocumento.DNI ? "DNI" : "RUC",
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
      ),
    );

    Widget registerButton = Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.maxFinite,
        child: RaisedButton(
            child: Text("Registrarse"), onPressed: _handleRegister));
    List<Widget> form;
    if (_tipo == TipoDeDocumento.DNI) {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        apellidosField,
        emailField,
        passwordField,
        registerButton
      ];
    } else {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        emailField,
        passwordField,
        registerButton
      ];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
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
              cubit: _bloc,
              listener: (context, state) {
                if (!state.loading) {
                  if (state.hasMessage) {
                    _showSuccess(state.message);
                  } else if (state.hasException) {
                    print("Register");
                    Alert(
                      context: context,
                      title: "Upss..",
                      desc: state.exception.message,
                      type: AlertType.error,
                    ).show();
                  }
                }
              },
              child: BlocBuilder<PerfilBloc, APIResponse>(
                cubit: _bloc,
                builder: (context, state) {
                  return state.loading ? LoadingWidget() : SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleRegister() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Cliente cliente;
      if (_tipo == TipoDeDocumento.DNI) {
        cliente = ClienteNatural(
            documento: _documento,
            nombre: _nombre,
            apellidos: _apellidos,
            correo: _email,
            password: _password);
      } else {
        cliente = ClienteJuridico(
            documento: _documento,
            razonSocial: _nombre,
            correo: _email,
            password: _password);
      }
      _bloc.register(cliente);
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
}
