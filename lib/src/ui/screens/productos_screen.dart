import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mr_yupi/src/model/caracteristicas.dart';
import 'package:mr_yupi/src/model/producto.dart';
import 'package:mr_yupi/src/ui/screens/producto_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/image_card_widget.dart';
import 'package:mr_yupi/src/ui/widgets/producto_widget.dart';

class ProductosScreen extends StatefulWidget {
  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  List<Producto> productos = [
    new Producto(
        id: 1,
        nombre: "Chivas regal - blended scotch whisky",
        descripcion: "Occaecat amet labore proident cillum veniam magna anim.",
        caracteristicas: [
          new Caracteristicas("Alto de escritorio (cm)", "78"),
          new Caracteristicas("Ancho de escritorio (cm)", "110"),
          new Caracteristicas("Profundidad de escritorio (cm)", "45"),
          new Caracteristicas("Material de tablero", "Melamina"),
          new Caracteristicas("Material de estructura", "Melamine")
        ],
        fotos: [
          "https://licoreria247.pe/content-borracho-total/uploads/2019/12/Whisky-Chivas-Regal-12-750ml-Licoreria247.png",
        ],
        stock: 20,
        precio: 9.90,
        descuento: 0.1),
    new Producto(
        id: 2,
        nombre: "Cubre volante deportivo sparco SPC1111GR gris",
        fotos: [
          "https://jumbocolombiafood.vteximg.com.br/arquivos/ids/176126-750-750/7702090032789-20-281-29.jpg"
        ],
        stock: 10,
        precio: 34),
    new Producto(
        id: 3,
        nombre: "Aspiradora auto 12v sparco SPV1302AZ azul",
        fotos: [
          'https://s7d2.scene7.com/is/image/TottusPE/41462527?\$S7Product\$&wid=458&hei=458&op_sharpen=0',
        ],
        stock: 0,
        precio: 99,
        descuento: 0.2),
    new Producto(
        id: 4,
        nombre:
            "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
        fotos: [
          "https://http2.mlstatic.com/refresco-hit-naranja-pet-15l-3-unidades-D_NQ_NP_630169-MLV43006172478_082020-F.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    new Producto(
        id: 4,
        nombre:
            "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
        fotos: [
          "https://pideygana.com/wp-content/uploads/2019/07/7702090023893-20-281-29.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    new Producto(
        id: 4,
        nombre:
            "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
        fotos: [
          "https://oechsle.vteximg.com.br/arquivos/ids/1348064-1500-1500/image-2a0db5dc261c4a5ba70c737a43937c2b.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    new Producto(
        id: 4,
        nombre:
            "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
        fotos: [
          "https://assets.pernod-ricard.com/styles/marque_mini_carrosselbreakpoints_theme_pernodricard_desktop_1x/s3/kahlua_especial.png"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    new Producto(
        id: 4,
        nombre:
            "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
        fotos: [
          "https://shop.torres.es/media/catalog/product/cache/2/small_image/332x431/9df78eab33525d08d6e5fb8d27136e95/c/a/calvados_vsop_1.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5)
  ];
  List<Producto> ofertas = [
    Producto(
        id: 5,
        nombre: "Combo 1",
        fotos: [
          "https://png.pngtree.com/png-vector/20190411/ourlarge/pngtree-job-vacancy-flat-design-concept-png-image_926058.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    Producto(
        id: 6,
        nombre: "Combo 2",
        fotos: [
          "https://png.pngtree.com/png-vector/20190821/ourlarge/pngtree-sale-discount-offer-banner-promotion-special-offer-price-vector-illustration-png-image_1693312.jpg",
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    Producto(
        id: 7,
        nombre: "Combo 3",
        fotos: [
          "https://png.pngtree.com/element_our/md/20180302/md_5a98f93a2fafc.jpg",
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    Producto(
        id: 8,
        nombre: "Combo 4",
        fotos: [
          "https://www.seekpng.com/png/detail/238-2388746_oferta-semana-de-ofertas-png.png",
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5),
    Producto(
        id: 9,
        nombre: "Combo 5",
        fotos: [
          "https://png.pngtree.com/element_our/png_detail/20181130/flash-sale-banner-template-special-offer-with-thunder-png_253955.jpg"
        ],
        stock: 16,
        precio: 24.99,
        descuento: 0.5)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 220,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: ofertas.map(
                (oferta) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ImageCardWidget(
                        elevation: 10,
                        margin: const EdgeInsets.only(
                          top: 18,
                          bottom: 18,
                          left: 9,
                          right: 9,
                        ),
                        imageUrl: oferta.fotos[0],
                        onTap: () => _handleProduct(oferta),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              height: 150,
              width: double.maxFinite,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 6,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                return ProductoWidget(
                  productos[index],
                  onTap: _handleProduct,
                );
              },
              childCount: productos.length,
            ),
          ),
        ),
      ],
    );
  }

  _handleProduct(Producto producto) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductoDetalleScreen(producto),
      ),
    );
  }
}
