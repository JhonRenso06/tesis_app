import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/model/enums/tipo_de_documento.dart';

class EditarPerfilScreen extends StatefulWidget {
  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  TipoDeDocumento _tipo;
  GlobalKey<FormState> _formKey;
  String _nombre, _apellidos, _email, _documento;

  @override
  void initState() {
    _tipo = TipoDeDocumento.DNI;
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
      ),
    );

    Widget registerButton = SizedBox(
      width: double.maxFinite,
      child: RaisedButton(
        onPressed: _onSave,
        child: Text("Guardar"),
      ),
    );

    List<Widget> form;
    if (_tipo == TipoDeDocumento.DNI) {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        apellidosField,
        emailField,
        registerButton
      ];
    } else {
      form = [
        logoWidget,
        tipoWidget,
        documentoField,
        nombreField,
        emailField,
        registerButton
      ];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Editar perfil",
      )),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: form,
            ),
          ),
        ),
      ),
    );
  }

  _onSave() {}
}
