import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/ui/screens/carrito_screen.dart';
import 'package:mr_yupi/src/ui/screens/categorias_screen.dart';
import 'package:mr_yupi/src/ui/screens/favoritos_screen.dart';
import 'package:mr_yupi/src/ui/screens/perfil_screen.dart';
import 'package:mr_yupi/src/ui/screens/productos_screen.dart';
import 'package:mr_yupi/src/ui/widgets/cantidad_carrito_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var carritoProvider = Provider.of<CarritoProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 247, 1),
      appBar: AppBar(
        title: Text("Mr. Yupi"),
        actions: [
          CantidadCarritoWidget(
            carritoProvider.cantidad,
            onTap: _handleCart,
          )
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Inicio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categorias"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favoritos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Cuenta"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
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
}
