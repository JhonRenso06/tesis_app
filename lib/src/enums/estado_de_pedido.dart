enum EstadoDePedido {
  EN_PROCESO,
  ATENDIDO,
  EN_CAMINO,
  ENTREGADO,
  CANCELADO,
}

extension EstadoDePedidoExtension on EstadoDePedido {
  String get name {
    switch (this) {
      case EstadoDePedido.EN_PROCESO:
        return "En proceso";
      case EstadoDePedido.ATENDIDO:
        return "Atendido";
      case EstadoDePedido.EN_CAMINO:
        return "En camino";
      case EstadoDePedido.ENTREGADO:
        return "Entregado";
      case EstadoDePedido.CANCELADO:
        return "Cancelado";
      default:
        return null;
    }
  }

  static EstadoDePedido parse(dynamic data) {
    for (EstadoDePedido estadoDePedido in EstadoDePedido.values) {
      if (estadoDePedido.index == data) {
        return estadoDePedido;
      }
    }
    return null;
  }
}
