// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mr_yupi/src/api/auth_api.dart';
// import 'package:mr_yupi/src/api/pedido_api.dart';
// import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
// import 'package:mr_yupi/src/bloc/categoria_bloc.dart';
// import 'package:mr_yupi/src/bloc/departamento_bloc.dart';
// import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
// import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
// import 'package:mr_yupi/src/bloc/favoritos_bloc.dart';
// import 'package:mr_yupi/src/bloc/pedido_bloc.dart';
// import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
// import 'package:mr_yupi/src/bloc/productos_bloc.dart';
// import 'package:mr_yupi/src/bloc/ultimo_pedido_bloc.dart';
// import 'package:mr_yupi/src/enums/estado_de_pedido.dart';
// import 'package:mr_yupi/src/global/global.dart';
// import 'package:mr_yupi/src/ui/screens/home_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:mr_yupi/src/ui/screens/pedido_detalle_screen.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:url_launcher/url_launcher.dart';

// class App extends StatelessWidget {
//   final NotificationAppLaunchDetails notificationAppLaunchDetails;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   final BehaviorSubject<String> selectNotificationSubject;
//   App(
//     this.notificationAppLaunchDetails,
//     this.flutterLocalNotificationsPlugin,
//     this.selectNotificationSubject,
//   );
//   final _firebaseMessage = FirebaseMessaging();
//   static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
//   static final manager = FlutterLocalNotificationsPlugin()
//     ..initialize(
//       InitializationSettings(
//         android: AndroidInitializationSettings("@drawable/icon_notification"),
//       ),
//       onSelectNotification: (payload) async {
//         Map<String, dynamic> message = jsonDecode(payload);
//         print("onSelectNotification $message");
//         var tipo = message["data"]["tipo"];
//         if (tipo == "estado") {
//           var estado = EstadoDePedidoExtension.parse(
//               int.parse(message["data"]["estado"]));
//           var pedido = int.parse(message["data"]["pedido"]);
//           if (estado == EstadoDePedido.ENTREGADO) {
//             launch("https://forms.gle/cQp6LUDHRjQxhLui7");
//           } else {
//             var result = await new PedidoAPI().getPedido(pedido);
//             if (result.hasData) {
//               _navigatorKey.currentState.push(
//                 MaterialPageRoute(
//                   builder: (context) => PedidoDetalleScreen(result.data),
//                 ),
//               );
//             }
//           }
//         }
//         return true;
//       },
//     );
//   static Future<dynamic> myBackgroundMessageHandler(
//       Map<String, dynamic> message) async {
//     showNotification(
//       message,
//     );
//   }

//   static showNotification(Map<String, dynamic> message) async {
//     var title = message["data"]["title"];
//     var body = message["data"]["body"];
//     var tipo = message["data"]["tipo"];
//     if (tipo == "market") {
//       var platform = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "market-channel",
//           "market",
//           "",
//           color: Colors.red,
//           enableLights: true,
//           largeIcon: DrawableResourceAndroidBitmap(
//             "@drawable/logo",
//           ),
//           styleInformation: MediaStyleInformation(),
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       );
//       await manager.show(0, title, body, platform);
//     } else if (tipo == "estado") {
//       var estado =
//           EstadoDePedidoExtension.parse(int.parse(message["data"]["estado"]));
//       var pedido = int.parse(message["data"]["pedido"]);
//       String imagen;
//       switch (estado) {
//         case EstadoDePedido.ATENDIDO:
//           imagen = "@drawable/immigration";
//           break;
//         case EstadoDePedido.EN_CAMINO:
//           imagen = "@drawable/delivery_truck";
//           break;
//         case EstadoDePedido.ENTREGADO:
//           imagen = "@drawable/delivery_box";
//           break;
//         case EstadoDePedido.CANCELADO:
//           imagen = "@drawable/cancel";
//           break;
//         default:
//           imagen = "@drawable/order";
//           break;
//       }
//       var platform = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "me-channel",
//           "me",
//           "",
//           color: Colors.red,
//           enableLights: true,
//           largeIcon: DrawableResourceAndroidBitmap(
//             imagen,
//           ),
//           styleInformation: MediaStyleInformation(),
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       );
//       await manager.show(
//         pedido,
//         title,
//         body,
//         platform,
//         payload: jsonEncode(message),
//       );
//     }
//   }

//   final _ultimoPedidoBloc = UltimoPedidoBloc();

//   @override
//   Widget build(BuildContext context) {
//     _firebaseMessage
//         .getToken()
//         .then((value) => new AuthAPI().subscription(value));
//     _firebaseMessage.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         showNotification(message);
//         _ultimoPedidoBloc.loadPedido();
//       },
//       onBackgroundMessage: myBackgroundMessageHandler,
//     );
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ProductosBloc>(
//           create: (_) => ProductosBloc(),
//         ),
//         BlocProvider<PerfilBloc>(
//           create: (_) => PerfilBloc(),
//         ),
//         BlocProvider<DireccionBloc>(
//           create: (_) => DireccionBloc(),
//         ),
//         BlocProvider<PedidoBloc>(
//           create: (_) => PedidoBloc(),
//         ),
//         BlocProvider<DepartamentoBloc>(
//           create: (_) => DepartamentoBloc(),
//         ),
//         BlocProvider<CategoriaBloc>(
//           create: (_) => CategoriaBloc(),
//         ),
//         BlocProvider<EstablecimientoBloc>(
//           create: (_) => EstablecimientoBloc(),
//         ),
//         BlocProvider<FavoritosBloc>(
//           create: (_) => FavoritosBloc(),
//         ),
//         BlocProvider<CarritoBloc>(
//           create: (_) => CarritoBloc(),
//         ),
//         BlocProvider<UltimoPedidoBloc>(
//           create: (_) => _ultimoPedidoBloc,
//         )
//       ],
//       child: MaterialApp(
//         title: "Yupi Chela",
//         home: HomeScreen(
//           this.notificationAppLaunchDetails,
//           this.flutterLocalNotificationsPlugin,
//           this.selectNotificationSubject,
//         ),
//         navigatorKey: _navigatorKey,
//         theme: ThemeData(
//           primaryColor: Global.primaryColor,
//           accentColor: Global.accentColor,
//           primaryColorDark: Global.primaryColorDark,
//           primaryColorLight: Global.primaryColorLight,
//           primarySwatch: Global.primarySwatch,
//           buttonTheme: Global.buttonTheme,
//           fontFamily: Global.fontFamily,
//           inputDecorationTheme: Global.inputDecorationTheme,
//           appBarTheme: Global.appBarTheme,
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//             elevation: 8,
//             selectedItemColor: Global.primarySwatch,
//             unselectedItemColor: Global.primarySwatch[300],
//             showUnselectedLabels: true,
//           ),
//           dividerColor: Global.primaryColorDark,
//         ),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
