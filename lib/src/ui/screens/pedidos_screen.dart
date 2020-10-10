import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/model/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/model/enums/moneda.dart';
import 'package:mr_yupi/src/model/enums/tipo_de_comprobante.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto.dart';
import 'package:mr_yupi/src/model/provincia.dart';
import 'package:mr_yupi/src/ui/screens/pedido_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/pedido_widget.dart';

class PedidosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidosScreen> {
  List<Pedido> pedidos = [
    Pedido(
      id: 1,
      direccion: Direccion(
        direccion: "Av Túpac Amaru 1419",
        distrito: Distrito(
          id: 1,
          nombre: "Trujillo",
          provincia: Provincia(
            id: 1,
            nombre: "Trujillo",
            departamento: Departamento(
              id: 1,
              nombre: "La libertad",
            ),
          ),
        ),
        nombre: "Pablo Rafael",
        apellidos: "Cruz López",
        telefono: "969647526",
        predeterminado: false,
      ),
      delivery: true,
      igv: 18,
      subtotal: 82,
      total: 100,
      metodoDePago: MetodoDePago.EFECTIVO,
      tipoDeComprobante: TipoDeComprobante.FACTURA,
      moneda: Moneda.SOLES,
      fechaDeEmision: DateTime.now(),
      fechaDeEntrega: DateTime.now(),
      estado: EstadoDePedido.ATENDIDO,
      lineasDePedido: [
        LineaDePedido(
          id: 1,
          cantidad: 4,
          precio: 12,
          subtotal: 48,
          producto: Producto(
              id: 3,
              nombre: "Aspiradora auto 12v sparco SPV1302AZ azul",
              fotos: [
                'https://s7d2.scene7.com/is/image/TottusPE/41462527?\$S7Product\$&wid=458&hei=458&op_sharpen=0',
              ],
              stock: 0,
              precio: 99,
              descuento: 0.2),
        ),
      ],
    ),
    Pedido(
        id: 2,
        direccion: Direccion(
          direccion: "Av Túpac Amaru 1419",
          distrito: Distrito(
            id: 1,
            nombre: "Trujillo",
            provincia: Provincia(
              id: 1,
              nombre: "Trujillo",
              departamento: Departamento(
                id: 1,
                nombre: "La libertad",
              ),
            ),
          ),
          nombre: "Pablo Rafael",
          apellidos: "Cruz López",
          telefono: "969647526",
          predeterminado: false,
        ),
        delivery: true,
        igv: 18,
        subtotal: 82,
        total: 100,
        metodoDePago: MetodoDePago.EFECTIVO,
        tipoDeComprobante: TipoDeComprobante.FACTURA,
        moneda: Moneda.SOLES,
        fechaDeEmision: DateTime.now(),
        fechaDeEntrega: DateTime.now(),
        estado: EstadoDePedido.CANCELADO,
        lineasDePedido: [
          LineaDePedido(
            id: 1,
            cantidad: 4,
            precio: 12,
            subtotal: 48,
            producto: Producto(
                id: 3,
                nombre: "Aspiradora auto 12v sparco SPV1302AZ azul",
                fotos: [
                  'https://s7d2.scene7.com/is/image/TottusPE/41462527?\$S7Product\$&wid=458&hei=458&op_sharpen=0',
                ],
                stock: 0,
                precio: 99,
                descuento: 0.2),
          ),
          LineaDePedido(
            id: 3,
            cantidad: 4,
            precio: 12,
            subtotal: 48,
            producto: Producto(
                id: 4,
                nombre:
                    "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
                fotos: [
                  "https://http2.mlstatic.com/refresco-hit-naranja-pet-15l-3-unidades-D_NQ_NP_630169-MLV43006172478_082020-F.jpg"
                ],
                stock: 16,
                precio: 24.99,
                descuento: 0.5),
          ),
          LineaDePedido(
            id: 2,
            cantidad: 4,
            precio: 12,
            subtotal: 48,
            producto: Producto(
                id: 4,
                nombre:
                    "Holder Soporte Celular Smartphone Brazo Extendible Auto Universal",
                fotos: [
                  "https://http2.mlstatic.com/refresco-hit-naranja-pet-15l-3-unidades-D_NQ_NP_630169-MLV43006172478_082020-F.jpg"
                ],
                stock: 16,
                precio: 24.99,
                descuento: 0.5),
          ),
        ]),
    Pedido(
        id: 3,
        direccion: Direccion(
          direccion: "Av Túpac Amaru 1419",
          distrito: Distrito(
            id: 1,
            nombre: "Trujillo",
            provincia: Provincia(
              id: 1,
              nombre: "Trujillo",
              departamento: Departamento(
                id: 1,
                nombre: "La libertad",
              ),
            ),
          ),
          nombre: "Pablo Rafael",
          apellidos: "Cruz López",
          telefono: "969647526",
          predeterminado: false,
        ),
        delivery: true,
        igv: 18,
        subtotal: 82,
        total: 100,
        metodoDePago: MetodoDePago.EFECTIVO,
        tipoDeComprobante: TipoDeComprobante.FACTURA,
        moneda: Moneda.SOLES,
        fechaDeEmision: DateTime.now(),
        estado: EstadoDePedido.EN_CAMINO,
        lineasDePedido: [
          LineaDePedido(
            id: 1,
            cantidad: 4,
            precio: 12,
            subtotal: 48,
            producto: Producto(
                id: 3,
                nombre: "Aspiradora auto 12v sparco SPV1302AZ azul",
                fotos: [
                  'https://s7d2.scene7.com/is/image/TottusPE/41462527?\$S7Product\$&wid=458&hei=458&op_sharpen=0',
                ],
                stock: 0,
                precio: 99,
                descuento: 0.2),
          ),
        ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis pedidos"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 7),
        itemCount: pedidos.length,
        itemBuilder: (BuildContext context, int index) {
          return PedidoWidget(
            pedidos[index],
            onTap: _toDetallePedido,
          );
        },
      ),
    );
  }

  _toDetallePedido(Pedido pedido) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PedidoDetalleScreen(pedido),
      ),
    );
  }
}
