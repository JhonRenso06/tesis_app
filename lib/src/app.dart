import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/categoria_bloc.dart';
import 'package:mr_yupi/src/bloc/departamento_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/favoritos_bloc.dart';
import 'package:mr_yupi/src/bloc/pedido_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/ui/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarritoProvider(),
      child: MultiBlocProvider(
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
      ),
    );
  }
}
