import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/login_screen.dart';
import 'package:tesis_app/src/ui/screens/signup_screen.dart';

class InicialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InicialScreenState();
  }
}

class _InicialScreenState extends State<InicialScreen> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: <Widget>[LoginScreen(), inicialScreen(), SignupScreen()],
        ));
  }

  inicialScreen() {
    var signinButtonHome = Material(
      color: Color.fromRGBO(0, 0, 0, 0),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _pageController.previousPage(
              duration: Duration(milliseconds: 800), curve: Curves.ease);
        },
        child: Text("Iniciar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
    );
    var signupButtonHome = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _pageController.nextPage(
              duration: Duration(milliseconds: 800), curve: Curves.ease);
        },
        child: Text("Registrarse",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ),
    );
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250.0,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            signinButtonHome,
            SizedBox(
              height: 15.0,
            ),
            signupButtonHome
          ],
        ),
      ),
    );
  }
}
