import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:mr_yupi/src/bloc/bloc_state.dart';
import 'package:mr_yupi/src/bloc/login_bloc.dart';
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
  LoginBloc _cubit;

  @override
  void initState() {
    _formKey = GlobalKey();
    _obscurePassword = true;
    _cubit = LoginBloc();
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

    Widget loginButton = Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        child: RaisedButton(
            child: Text("Iniciar sesión"), onPressed: _handleLogin));

    Widget registerButton = Container(
        margin: const EdgeInsets.only(right: 6),
        width: double.maxFinite,
        child: FlatButton(onPressed: _toRegister, child: Text("Registrate")));

    Widget forgetPasswordButton = Container(
        margin: const EdgeInsets.only(left: 6),
        width: double.maxFinite,
        child: FlatButton(
            onPressed: _toRegister,
            child: Text(
              "¿Olvidaste tu contraseña?",
              textAlign: TextAlign.center,
            )));

    Widget emailField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Email",
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
        padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                        loginButton,
                        Row(
                          children: [
                            Flexible(flex: 1, child: registerButton),
                            //Flexible(flex: 1, child: forgetPasswordButton)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              BlocListener<LoginBloc, BlocState<APIMessage>>(
                cubit: _cubit,
                listener: (context, state) {
                  if (state is LoadedState) {
                    _showSuccess(state.message);
                  }
                  if (state is ErrorState) {
                    Alert(
                      context: context,
                      title: "Upss..",
                      desc: state.exception.message,
                      type: AlertType.error,
                    ).show();
                  }
                },
                child: SizedBox.shrink(),
              ),
              BlocBuilder<LoginBloc, BlocState<APIMessage>>(
                cubit: _cubit,
                builder: (context, state) {
                  return state is LoadingState
                      ? LoadingWidget()
                      : SizedBox.shrink();
                },
              ),
            ],
          )),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _cubit.login(Cliente(correo: _email, password: _password));
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
      Navigator.pop(context);
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

  void _toForgetPassword() async {}
}
