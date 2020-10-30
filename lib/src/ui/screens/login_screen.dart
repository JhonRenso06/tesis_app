import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/ui/screens/recuperar_password_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/ui/screens/register_screen.dart';
import 'package:mr_yupi/src/ui/widgets/loading_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey;
  String _email, _password;
  bool _obscurePassword;

  Map<String, FocusNode> focusMap = {
    "email": FocusNode(),
    "password": FocusNode(),
    "login": FocusNode(),
  };

  @override
  void initState() {
    _formKey = GlobalKey();
    _obscurePassword = true;
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

    Widget loginButton = Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        child: RaisedButton(
            focusNode: focusMap["login"],
            child: Text("Iniciar sesión"),
            onPressed: _handleLogin));

    Widget registerButton = Container(
        margin: const EdgeInsets.only(right: 6),
        width: double.maxFinite,
        child: FlatButton(onPressed: _toRegister, child: Text("Registrate")));

    Widget forgetPasswordButton = Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlatButton(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            onPressed: _toForgetPassword,
            child: Text(
              "¿Olvidaste tu contraseña?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    Widget emailField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Email",
      ),
      focusNode: focusMap["email"],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(focusMap["password"]),
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
    );

    Widget passwordField = Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 0),
        child: TextFormField(
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(focusMap["login"]);
          },
          focusNode: focusMap["password"],
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
          onSaved: (val) {
            _password = val;
          },
          validator: (val) {
            if (val.isEmpty) {
              return "Campo requerido";
            } else if (val.length < 6) {
              return "Ingrese una contraseña valida";
            }
            return null;
          },
        ));

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
                      children: <Widget>[
                        logoWidget,
                        emailField,
                        passwordField,
                        forgetPasswordButton,
                        loginButton,
                        Row(
                          children: [
                            Flexible(flex: 1, child: registerButton),
                          ],
                        )
                      ],
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
                      print("Login");
                      Alert(
                        context: context,
                        title: "¡Uy!",
                        desc: state.exception.message,
                        type: AlertType.error,
                      ).show();
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: SizedBox.shrink(),
              ),
              BlocBuilder<PerfilBloc, APIResponse<Cliente>>(
                cubit: context.bloc<PerfilBloc>(),
                builder: (context, state) {
                  return state.loading ? LoadingWidget() : SizedBox.shrink();
                },
              ),
            ],
          )),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context
          .bloc<PerfilBloc>()
          .login(Cliente(correo: _email, password: _password));
    }
  }

  void _toRegister() async {
    bool result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
    if (result != null && result) {
      print("Registro existo");
      Navigator.pop(context, true);
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

  void _toForgetPassword() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecuperarPasswordScreen(),
      ),
    );
  }
}
