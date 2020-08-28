import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/widgets/item_widget.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg"
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 147),
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 20, top: 7),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemWidget(index, items[index]);
                }),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 24),
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container(height: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Subtotal:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold))),
                        Text("S/10000",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("IGV:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold))),
                        Text("S/2000",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Total:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold))),
                        Text("S/12000",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                Container(height: 6),
                Divider(color: Colors.white),
                Container(height: 6),
                Container(
                  height: 30,
                  child: Material(
                    color: Colors.black,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        print("Ir al método de pago");
                      },
                      child: Text("Procesar pedido",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Quicksand",
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
