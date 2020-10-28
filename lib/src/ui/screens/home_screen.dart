import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/provincia.dart';
import 'package:mr_yupi/src/ui/screens/carrito_screen.dart';
import 'package:mr_yupi/src/ui/screens/categorias_screen.dart';
import 'package:mr_yupi/src/ui/screens/favoritos_screen.dart';
import 'package:mr_yupi/src/ui/screens/perfil_screen.dart';
import 'package:mr_yupi/src/ui/screens/productos_screen.dart';
import 'package:mr_yupi/src/ui/screens/productos_search_screen.dart';
import 'package:mr_yupi/src/ui/widgets/cantidad_carrito_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  showNotification(FlutterLocalNotificationsPlugin(), message);
}

showNotification(FlutterLocalNotificationsPlugin manager,
    Map<String, dynamic> message) async {
  manager.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings("@drawable/icon_notification"),
    ),
  );
  var title = message["data"]["title"];
  var body = message["data"]["body"];
  var tipo = message["data"]["tipo"];
  if (tipo == "market") {
    var platform = NotificationDetails(
      android: AndroidNotificationDetails(
        "market-channel",
        "market",
        "",
        color: Colors.red,
        enableLights: true,
        largeIcon: DrawableResourceAndroidBitmap(
          "@drawable/logo",
        ),
        styleInformation: MediaStyleInformation(),
      ),
    );
    await manager.show(0, title, body, platform);
  } else if (tipo == "estado") {
    var estado =
        EstadoDePedidoExtension.parse(int.parse(message["data"]["estado"]));
    var pedido = int.parse(message["data"]["pedido"]);
    String imagen;
    switch (estado) {
      case EstadoDePedido.ATENDIDO:
        imagen = "@drawable/immigration";
        break;
      case EstadoDePedido.EN_CAMINO:
        imagen = "@drawable/delivery_truck";
        break;
      case EstadoDePedido.ENTREGADO:
        imagen = "@drawable/delivery_box";
        break;
      case EstadoDePedido.CANCELADO:
        imagen = "@drawable/cancel";
        break;
      default:
        imagen = "@drawable/order";
        break;
    }
    var platform = NotificationDetails(
      android: AndroidNotificationDetails(
        "me-channel",
        "me",
        "",
        color: Colors.red,
        enableLights: true,
        largeIcon: DrawableResourceAndroidBitmap(
          imagen,
        ),
        styleInformation: MediaStyleInformation(),
      ),
    );
    await manager.show(pedido, title, body, platform);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex;
  List<Widget> _widgetOptions = [
    ProductosScreen(),
    CategoriasScreen(),
    FavoritosScreen(),
    PerfilScreen()
  ];
  FirebaseMessaging _firebaseMessage;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    context.bloc<PerfilBloc>().getCurrentClient();
    context.bloc<EstablecimientoBloc>().initialLoad();
    _selectedIndex = 0;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _firebaseMessage = FirebaseMessaging();
    _firebaseMessage.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(_flutterLocalNotificationsPlugin, message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (message) async {
        print(message);
      },
      onLaunch: (message) async {
        print("OnLaunch");
        print(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EstablecimientoBloc, Establecimiento>(
      listener: (context, state) {
        context.bloc<CarritoBloc>().getCarrito(state);
        if (state != null &&
            context.bloc<EstablecimientoBloc>().defaultSelected) {
          _showEstablecimientos();
        }
      },
      child: BlocBuilder<EstablecimientoBloc, Establecimiento>(
        builder: (context, state) {
          if (state != null) {
            return homeWidget(state);
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 150,
                    width: 150,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget homeWidget(Establecimiento establecimiento) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 247, 1),
      appBar: AppBar(
        title: InkWell(
          child: Text(establecimiento.nombre),
          onTap: () {
            _showEstablecimientos();
          },
        ),
        leading: CantidadCarritoWidget(
          onTap: _handleCart,
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: _onSearch),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categorias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Cuenta",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  _showEstablecimientos() async {
    if (context.bloc<EstablecimientoBloc>().establecimientosSize == 1) {
      return;
    }
    await Alert(
      title: "Elige un establecimiento",
      context: context,
      content: DialogEstablecimiento(
        (establecimiento) {
          Navigator.of(context).pop();
          context.bloc<EstablecimientoBloc>().establecimiento = establecimiento;
          context.bloc<ProductosBloc>().initialLoad(establecimiento);
        },
      ),
      buttons: [],
    ).show();
  }

  _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  _handleCart() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CarritoScreen()));
  }

  _onSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductosSearchScreen(),
      ),
    );
  }
}

class DialogEstablecimiento extends StatefulWidget {
  final Function(Establecimiento) onSubmit;
  DialogEstablecimiento(this.onSubmit);

  @override
  _DialogEstablecimientoState createState() => _DialogEstablecimientoState();
}

class _DialogEstablecimientoState extends State<DialogEstablecimiento> {
  List<DropdownMenuItem<Departamento>> departamentoItems;
  List<DropdownMenuItem<Provincia>> provinciaItems;
  List<DropdownMenuItem<Establecimiento>> establecimientosItems;
  Departamento _departamentoSelected;
  Provincia _provinciaSelected;
  Establecimiento _establecimientoSelected;
  GlobalKey<FormState> _formKey = GlobalKey();
  List<Departamento> departamentos;
  @override
  void initState() {
    var initValue = context.bloc<EstablecimientoBloc>().state;
    departamentos = context.bloc<EstablecimientoBloc>().departamentos;
    departamentoItems = [
      DropdownMenuItem(
        child: Text("-- elige un departamento --"),
        value: null,
      )
    ];

    provinciaItems = [
      DropdownMenuItem(
        child: Text("-- elige una provincia --"),
        value: null,
      )
    ];

    establecimientosItems = [
      DropdownMenuItem(
        child: Text("-- elige un establecimiento --"),
        value: null,
      )
    ];
    departamentos.forEach((element) {
      departamentoItems.add(DropdownMenuItem(
        child: Text(element.nombre),
        value: element,
      ));
    });
    if (initValue != null) {
      departamentos.forEach((dep) {
        dep.provincias.forEach((prov) {
          prov.establecimientos.forEach((est) {
            if (est.id == initValue.id) {
              _departamentoSelected = dep;
              dep.provincias.forEach(
                (element) {
                  provinciaItems.add(
                    DropdownMenuItem(
                      child: Text(element.nombre),
                      value: element,
                    ),
                  );
                },
              );
              _provinciaSelected = prov;
              prov.establecimientos.forEach(
                (element) {
                  establecimientosItems.add(
                    DropdownMenuItem(
                      child: Text(element.nombre),
                      value: element,
                    ),
                  );
                },
              );
              _establecimientoSelected = est;
            }
          });
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          DropdownButtonFormField(
            value: _departamentoSelected,
            items: departamentoItems,
            onChanged: onChangeDepartamento,
            validator: (val) {
              if (val == null) {
                return "Seleccione un departamento";
              }
              return null;
            },
          ),
          SizedBox(
            height: 12,
          ),
          DropdownButtonFormField(
            value: _provinciaSelected,
            items: provinciaItems,
            onChanged: onChangeProvincia,
            validator: (val) {
              if (val == null) {
                return "Seleccione una provincia";
              }
              return null;
            },
          ),
          SizedBox(
            height: 12,
          ),
          DropdownButtonFormField(
            value: _establecimientoSelected,
            items: establecimientosItems,
            onChanged: (value) {
              setState(() {
                _establecimientoSelected = value;
              });
            },
            validator: (val) {
              if (val == null) {
                return "Seleccione un establecimiento";
              }
              return null;
            },
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.maxFinite,
            child: RaisedButton(
              onPressed: onSubmit,
              child: Text("Elegir"),
            ),
          )
        ],
      ),
    );
  }

  onSubmit() {
    if (_formKey.currentState.validate()) {
      widget.onSubmit(_establecimientoSelected);
    }
  }

  onChangeDepartamento(Departamento value) {
    _departamentoSelected = value;
    _provinciaSelected = null;
    _establecimientoSelected = null;
    provinciaItems.clear();
    establecimientosItems.clear();
    provinciaItems.add(
      DropdownMenuItem(
        child: Text("-- elige una provincia --"),
        value: null,
      ),
    );
    establecimientosItems.add(
      DropdownMenuItem(
        child: Text("-- elige un establecimiento --"),
        value: null,
      ),
    );
    if (value != null && value.provincias != null) {
      value.provincias.forEach((element) {
        provinciaItems.add(
          DropdownMenuItem(
            child: Text(element.nombre),
            value: element,
          ),
        );
      });
    }
    setState(() {});
  }

  onChangeProvincia(Provincia provincia) {
    _establecimientoSelected = null;
    _provinciaSelected = provincia;
    establecimientosItems.clear();
    establecimientosItems.add(
      DropdownMenuItem(
        child: Text("-- elige un establecimiento --"),
        value: null,
      ),
    );
    if (provincia != null && provincia.establecimientos != null) {
      provincia.establecimientos.forEach((element) {
        establecimientosItems.add(
          DropdownMenuItem(
            child: Text(element.nombre),
            value: element,
          ),
        );
      });
    }
    setState(() {});
  }
}
