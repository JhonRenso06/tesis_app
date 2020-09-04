import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/direccion_screen.dart';
import 'package:tesis_app/src/ui/screens/editar_perfil_screen.dart';
import 'package:tesis_app/src/ui/widgets/direccion_widget.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;
    List<String> direcciones = [
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Column(
          children: <Widget>[
            Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                      minWidth: 30,
                      padding: EdgeInsets.all(2),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarPerfilScreen()),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ),
                width: width,
                height: width / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover,
                  ),
                )),
            Material(
              color: Color.fromRGBO(252, 249, 249, 1),
              child: Container(
                  height: width / 4,
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: width / 4,
                        height: width / 4,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: width,
                          backgroundImage:
                              AssetImage("assets/default_user.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Renso Vasquez Quiroz",
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "06 Noviembre 1998",
                            style: TextStyle(
                                fontSize: 12.5, fontFamily: "Quicksand"),
                          ),
                          Text(
                            "rensovasquez2014@gmail.com",
                            style: TextStyle(
                                fontSize: 12.5, fontFamily: "Quicksand"),
                          )
                        ],
                      ),
                    ),
                  ])),
            ),
          ],
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                "Mis direcciones de envío",
                style: TextStyle(fontFamily: "Quicksand", fontSize: 13),
              )),
              MaterialButton(
                // minWidth: 30,
                padding: EdgeInsets.only(left: 40),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DireccionScreen("Agregar dirección")),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 25,
                ),
              ),
            ],
          ),
        )),
        SliverToBoxAdapter(
          child: CarouselSlider(
            options: CarouselOptions(
                height: 200, enableInfiniteScroll: true, autoPlay: true),
            items: direcciones.map((oferta) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: DireccionWidget())
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        )
        // SliverList(
        //     delegate: SliverChildBuilderDelegate((context, index) {
        //   return Padding(
        //       padding: const EdgeInsets.all(10), child: DireccionWidget());
        // }, childCount: 4))
      ],
    );
  }
}
