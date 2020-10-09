import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/ui/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarritoProvider(),
      child: MaterialApp(
        home: HomeScreen(),
        //home: InicialScreen(),
        theme: ThemeData(
          primaryColor: Global.primaryColor,
          accentColor: Global.accentColor,
          primaryColorDark: Global.primaryColorDark,
          primaryColorLight: Global.primaryColorLight,
          primarySwatch: Global.primarySwatch,
          buttonTheme: Global.buttonTheme,
          fontFamily: Global.fontFamily,
          inputDecorationTheme: Global.inputDecorationTheme,
          appBarTheme: Global.appBarTheme,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 8,
            selectedItemColor: Global.primarySwatch,
            unselectedItemColor: Global.primarySwatch[300],
            showUnselectedLabels: true,
          ),
          dividerColor: Global.primaryColorDark,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
