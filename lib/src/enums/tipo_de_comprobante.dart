enum TipoDeComprobante {
  BOLETA,
  FACTURA,
}

extension TipoDeComprobanteExtension on TipoDeComprobante {
  String get name {
    switch (this) {
      case TipoDeComprobante.BOLETA:
        return "Boleta";
      case TipoDeComprobante.FACTURA:
        return "Factura";
      default:
        return null;
    }
  }

  static TipoDeComprobante parse(dynamic data) {
    for (TipoDeComprobante tipoDeComprobante in TipoDeComprobante.values) {
      if (tipoDeComprobante.index == data) {
        return tipoDeComprobante;
      }
    }
    return null;
  }
}
