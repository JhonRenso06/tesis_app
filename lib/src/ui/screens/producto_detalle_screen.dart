import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/ui/screens/carrito_screen.dart';
import 'package:mr_yupi/src/ui/widgets/image_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:mr_yupi/src/providers/carrito_provider.dart';
import 'package:mr_yupi/src/model/producto.dart';
import 'package:mr_yupi/src/ui/widgets/cantidad_carrito_widget.dart';
import 'package:mr_yupi/src/ui/widgets/caracteristicas_widget.dart';

class ProductoDetalleScreen extends StatefulWidget {
  final Producto producto;

  ProductoDetalleScreen(this.producto);

  @override
  State<StatefulWidget> createState() => _ProductoDetalleScreen();
}

class _ProductoDetalleScreen extends State<ProductoDetalleScreen> {
  TextEditingController _controller = new TextEditingController();
  int _cantidad, _current;
  double _widthCantidad = 45;
  initState() {
    super.initState();
    _cantidad = 1;
    _current = 0;
    _controller.value = _controller.value.copyWith(text: "1");
  }

  @override
  Widget build(BuildContext context) {
    var carritoProvider = Provider.of<CarritoProvider>(context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                actions: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Material(
                      color: Colors.transparent,
                      child: CantidadCarritoWidget(
                        carritoProvider.cantidad,
                        onTap: _toCart,
                      ),
                    ),
                  ),
                ],
                expandedHeight: MediaQuery.of(context).size.width * 0.9,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: double.maxFinite,
                            onPageChanged: (index, _) {
                              setState(() {
                                _current = index;
                              });
                            },
                            enableInfiniteScroll: false,
                            autoPlay: false,
                          ),
                          items: widget.producto.fotos.map((foto) {
                            return ImageCardWidget(
                              imageUrl: foto,
                              margin: const EdgeInsets.all(0),
                              radius: 0,
                              fit: BoxFit.contain,
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.producto.fotos.map((foto) {
                              int index = widget.producto.fotos.indexOf(foto);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Color.fromRGBO(77, 17, 48, 1)
                                      : Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        height:
                            kToolbarHeight + MediaQuery.of(context).padding.top,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black26, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          widget.producto.nombre,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(224, 224, 224, 1),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: _precioWidget,
                          flex: 1,
                        ),
                        Flexible(
                          child: _cantidadPicker,
                          flex: 1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(224, 224, 224, 1),
                      ),
                    ),
                    RaisedButton.icon(
                      onPressed: widget.producto.stock > 0 ? _addCart : null,
                      label: Text("Agregar al carrito"),
                      icon: Icon(Icons.add_shopping_cart),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Divider(
                        color: Color.fromRGBO(224, 224, 224, 1),
                      ),
                    ),
                    if (widget.producto.descripcion != null)
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              "Descripción",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: Divider(
                              color: Color.fromRGBO(224, 224, 224, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: Text(
                              widget.producto.descripcion,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: Divider(
                              color: Color.fromRGBO(224, 224, 224, 1),
                            ),
                          ),
                        ],
                      ),
                    if (widget.producto.caracteristicas != null)
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              "Características",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: Divider(
                              color: Color.fromRGBO(224, 224, 224, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            child: CaracteristicasWidget(
                              widget.producto.caracteristicas,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _precioWidget {
    if (widget.producto.descuento != null && widget.producto.descuento > 0) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "S/ ${widget.producto.precio.toStringAsFixed(2)}",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                " - ${widget.producto.porcentajeDescuento.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "S/ ${widget.producto.precioDescuento.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Global.accentColor,
            ),
          ),
        ],
      );
    }

    return Text(
      "S/ ${widget.producto.precio.toStringAsFixed(2)}",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget get _cantidadPicker {
    if (widget.producto.stock != null && widget.producto.stock > 0) {
      return SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: _widthCantidad,
              child: OutlineButton(
                onPressed: _handleLess,
                child: Center(
                  child: Icon(
                    Icons.remove,
                    textDirection: TextDirection.ltr,
                    color: Colors.black,
                  ),
                ),
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _widthCantidad,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSubmitted: _handleSubmit,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Global.accentColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Global.primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _widthCantidad,
              child: OutlineButton(
                onPressed: _handlePlus,
                child: Center(
                  child: Icon(
                    Icons.add,
                    textDirection: TextDirection.ltr,
                    color: Colors.black,
                  ),
                ),
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        "Agotado",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  _toCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CarritoScreen(),
      ),
    );
  }

  _handlePlus() {
    if (_cantidad < widget.producto.stock) {
      _cantidad++;
      _controller.value =
          _controller.value.copyWith(text: _cantidad.toString());
    }
  }

  _handleLess() {
    if (_cantidad > 1) {
      _cantidad--;
      _controller.value =
          _controller.value.copyWith(text: _cantidad.toString());
    }
  }

  _handleSubmit(str) {
    int cantidad;
    if (str == "") {
      cantidad = 0;
    } else {
      cantidad = int.parse(str);
    }
    if (!(cantidad > 0 && cantidad < widget.producto.stock)) {
      _controller.value =
          _controller.value.copyWith(text: _cantidad.toString());
    } else {
      _cantidad = cantidad;
    }
  }

  _addCart() {
    var carritoProvider = Provider.of<CarritoProvider>(context, listen: false);
    carritoProvider.addLineaDePedido(_cantidad, widget.producto);
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Se agrego al carrito")));
  }
}
