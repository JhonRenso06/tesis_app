import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_message.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/ui/widgets/loading_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditarPasswordScreen extends StatefulWidget {
  EditarPasswordScreen();

  @override
  _EditarPasswordScreenState createState() => _EditarPasswordScreenState();
}

class _EditarPasswordScreenState extends State<EditarPasswordScreen> {
  GlobalKey<FormState> _formKey;
  String _currentPassword, _newPassword;
  bool _obscureCurrentPassword, _obscureNewPassword;
  PerfilBloc _bloc;

  Map<String, FocusNode> focusMap = {
    "currentPassword": FocusNode(),
    "newPassword": FocusNode(),
    "cambiar": FocusNode(),
  };

  @override
  void initState() {
    _formKey = GlobalKey();
    _obscureCurrentPassword = true;
    _obscureNewPassword = true;
    _bloc = PerfilBloc();
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
    Widget currentPasswordField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["currentPassword"],
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["newPassword"]),
        obscureText: _obscureCurrentPassword,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: "Contraseña actual",
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
                  _obscureCurrentPassword = !_obscureCurrentPassword;
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
          _currentPassword = val;
        },
      ),
    );

    Widget newPasswordField = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        focusNode: focusMap["newPassword"],
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(focusMap["cambiar"]),
        obscureText: _obscureCurrentPassword,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: "Nueva contraseña",
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
                  _obscureNewPassword = !_obscureNewPassword;
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
          _newPassword = val;
        },
      ),
    );

    Widget cambiarButton = SizedBox(
      width: double.maxFinite,
      child: RaisedButton(
        focusNode: focusMap["cambiar"],
        onPressed: _onSave,
        child: Text("Cambiar contraseña"),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Cambiar contraseña",
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
                    children: [
                      logoWidget,
                      currentPasswordField,
                      newPasswordField,
                      cambiarButton
                    ],
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
              cubit: _bloc,
              builder: (context, state) {
                return state.loading ? LoadingWidget() : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  _onSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_currentPassword == _newPassword) {
        Alert(
            context: context,
            title: "¡Uy!",
            desc: "La nueva contraseña debe ser diferente a la actual",
            type: AlertType.error,
            buttons: [
              DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]).show();
      } else {
        _bloc.changePassword(_currentPassword, _newPassword);
      }
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
