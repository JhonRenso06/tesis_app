enum DocumentoComercial { BOLETA, FACTURA }

extension DocumentoComercialExtension on DocumentoComercial {
  String get name {
    switch (this) {
      case DocumentoComercial.BOLETA:
        return "Boleta";
      case DocumentoComercial.FACTURA:
        return "Factura";
      default:
        return null;
    }
  }

  static DocumentoComercial parse(dynamic data) {
    for (DocumentoComercial documentoComercial in DocumentoComercial.values) {
      if (documentoComercial.index == data) {
        return documentoComercial;
      }
    }
    return null;
  }
}
