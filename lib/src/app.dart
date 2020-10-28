import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/api/auth_api.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/categoria_bloc.dart';
import 'package:mr_yupi/src/bloc/departamento_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/favoritos_bloc.dart';
import 'package:mr_yupi/src/bloc/pedido_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/bloc/ultimo_pedido_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/ui/screens/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class App extends StatelessWidget {
  final _firebaseMessage = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    _firebaseMessage
        .getToken()
        .then((value) => new AuthAPI().subscription(value));
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductosBloc>(
          create: (_) => ProductosBloc(),
        ),
        BlocProvider<PerfilBloc>(
          create: (_) => PerfilBloc(),
        ),
        BlocProvider<DireccionBloc>(
          create: (_) => DireccionBloc(),
        ),
        BlocProvider<PedidoBloc>(
          create: (_) => PedidoBloc(),
        ),
        BlocProvider<DepartamentoBloc>(
          create: (_) => DepartamentoBloc(),
        ),
        BlocProvider<CategoriaBloc>(
          create: (_) => CategoriaBloc(),
        ),
        BlocProvider<EstablecimientoBloc>(
          create: (_) => EstablecimientoBloc(),
        ),
        BlocProvider<FavoritosBloc>(
          create: (_) => FavoritosBloc(),
        ),
        BlocProvider<CarritoBloc>(
          create: (_) => CarritoBloc(),
        ),
        BlocProvider<UltimoPedidoBloc>(
          create: (_) => UltimoPedidoBloc(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
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
