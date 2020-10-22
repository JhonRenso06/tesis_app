enum TipoDeDocumento {
  DNI,
  RUC,
}

extension TipoDeDocumentoExtension on TipoDeDocumento {
  String get name {
    switch (this) {
      case TipoDeDocumento.DNI:
        return "DNI";
      case TipoDeDocumento.RUC:
        return "RUC";
      default:
        return null;
    }
  }

  static TipoDeDocumento parse(dynamic data) {
    for (TipoDeDocumento tipoDeDocumento in TipoDeDocumento.values) {
      if (tipoDeDocumento.index == data) {
        return tipoDeDocumento;
      }
    }
    return null;
  }
}
