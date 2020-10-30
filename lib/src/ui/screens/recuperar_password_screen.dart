import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RecuperarPasswordScreen extends StatefulWidget {
  @override
  _RecuperarPasswordScreenState createState() =>
      _RecuperarPasswordScreenState();
}

class _RecuperarPasswordScreenState extends State<RecuperarPasswordScreen> {
  GlobalKey<FormState> _formKey;
  String _email;
  PerfilBloc _bloc;
  @override
  void initState() {
    _formKey = GlobalKey();
    _bloc = PerfilBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Recuperar contraseña"),
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSaved: (val) {
                  _email = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Campo requerido";
                  } else if (!EmailValidator.validate(val)) {
                    return "Ingrese un email";
                  }
                  return null;
                },
              ),
              BlocListener<PerfilBloc, APIResponse<Cliente>>(
                cubit: _bloc,
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
                child: BlocBuilder<PerfilBloc, APIResponse<Cliente>>(
                  cubit: _bloc,
                  builder: (context, state) {
                    if (state.loading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(right: 6, top: 12),
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: _recoverPassword,
                        child: Text("Solicitar"),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _recoverPassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _bloc.recoverPassword(_email);
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
