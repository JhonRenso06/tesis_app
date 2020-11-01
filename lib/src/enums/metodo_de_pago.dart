enum MetodoDePago {
  EFECTIVO,
  TARJETA,
  TRANSFERENCIA,
}

extension MetodoDePagoExtension on MetodoDePago {
  String get name {
    switch (this) {
      case MetodoDePago.EFECTIVO:
        return "Efectivo";
      case MetodoDePago.TARJETA:
        return "Tarjeta";
      case MetodoDePago.TRANSFERENCIA:
        return "Transferencia";
      default:
        return null;
    }
  }

  static MetodoDePago parse(dynamic data) {
    for (MetodoDePago metodoDePago in MetodoDePago.values) {
      if (metodoDePago.index == data) {
        return metodoDePago;
      }
    }
    return null;
  }
}
