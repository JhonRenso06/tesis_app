import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tesis_app/src/model/caracteristicas.dart';
import 'package:tesis_app/src/model/pedido.dart';
import 'package:tesis_app/src/model/producto.dart';
import 'package:tesis_app/src/ui/widgets/producto_widget.dart';

class ProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Producto> productos = [
      new Producto(
          id: 1,
          nombre:
              "Espejo Visera HD - Visor Antideslumbrante Visera Para Auto Parasol - Para El Día Y La Noche",
          descripcion:
              "Occaecat amet labore proident cillum veniam magna anim.",
          caracteristicas: [
            new Caracteristicas("Alto de escritorio (cm)", "78"),
            new Caracteristicas("Ancho de escritorio (cm)", "110"),
            new Caracteristicas("Profundidad de escritorio (cm)", "45"),
            new Caracteristicas("Material de tablero", "Melamina"),
            new Caracteristicas("Material de estructura", "Melamine")
          ],
          fotos: [
            "https://i.linio.com/p/bd569f9ab534989ec79184e56d323a83-zoom.webp",
            "https://i.linio.com/p/57acb9aca5afb465f41000764a265eff-zoom.webp",
            "https://i.linio.com/p/a1658766902940d3b518b98547554301-zoom.webp"
          ],
          stock: 20,
          precio: 9.90,
          descuento: 0.1),
      new Producto(
          id: 2,
          nombre: "Cubre volante deportivo sparco SPC1111GR gris",
          fotos: [
            "https://i.linio.com/p/74776ea7bffcb8b549babc25bfa43538-zoom.webp"
          ],
          stock: 10,
          precio: 34),
      new Producto(
          id: 3,
          nombre: "Aspiradora auto 12v sparco SPV1302AZ azul",
          fotos: [
            "https://i.linio.com/p/684bf4ea18c3299582542b1483b31a38-zoom.webp",
            "https://i.linio.com/p/152a3e776417026d32c35d29520b6d50-zoom.webp",
            "https://i.linio.com/p/e339f277cdf44606bd645f0f2387eca0-zoom.webp",
            "https://i.linio.com/p/7799ee5b62c8970d107f8f5774b86689-zoom.webp",
            "https://i.linio.com/p/819092b8cae281e005459db738c7afda-zoom.webp"
          ],
          stock: 0,
          precio: 99,
          descuento: 0.2),
      new Producto(
          id: 4,
          nombre:
              "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
          fotos: [
            "https://i.linio.com/p/ce8fd941442525eb0b25d1b55281805c-zoom.webp"
          ],
          stock: 16,
          precio: 24.99,
          descuento: 0.5)
    ];
    List<String> ofertas = [
      "https://png.pngtree.com/png-vector/20190411/ourlarge/pngtree-job-vacancy-flat-design-concept-png-image_926058.jpg",
      "https://png.pngtree.com/png-vector/20190821/ourlarge/pngtree-sale-discount-offer-banner-promotion-special-offer-price-vector-illustration-png-image_1693312.jpg",
      "https://png.pngtree.com/element_our/md/20180302/md_5a98f93a2fafc.jpg",
      "https://www.seekpng.com/png/detail/238-2388746_oferta-semana-de-ofertas-png.png",
      "https://png.pngtree.com/element_our/png_detail/20181130/flash-sale-banner-template-special-offer-with-thunder-png_253955.jpg"
    ];

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 200, enableInfiniteScroll: true, autoPlay: true),
              items: ofertas.map((oferta) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: 400,
                              height: 200,
                              child: Image.network(
                                oferta,
                                fit: BoxFit.contain,
                              )),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                  color: Colors.black,
                  height: 150,
                  width: double.maxFinite,
                  child: Image.asset(
                    "assets/logo_blanco.png",
                    fit: BoxFit.contain,
                  ))),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 3 / 3.5,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return ProductoWidget(productos[index]);
            },
            childCount: productos.length,
          ),
        )
      ],
    );
  }
}
