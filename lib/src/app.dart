import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/src/providers/carrito_provider.dart';
import 'package:tesis_app/src/ui/screens/inicial_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarritoProvider(),
      child: MaterialApp(
        // home: HomeScreen(),
        home: InicialScreen(),
        theme: ThemeData(
            primaryColor: Color.fromRGBO(255, 45, 0, 1),
            fontFamily: 'Quicksand',
            inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(32.0)),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)))),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
