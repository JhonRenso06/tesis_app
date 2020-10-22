enum TipoDeDireccion {
  CASA,
  DEPARTAMENTO,
  CONDOMINIO,
  RESIDENCIAL,
  OFICINA,
  LOCAL,
  CENTRO,
  MERCADO,
  GALERIA,
  OTRO
}

extension TipoDeDireccionExtension on TipoDeDireccion {
  String get name {
    switch (this) {
      case TipoDeDireccion.CASA:
        return "Casa";
      case TipoDeDireccion.DEPARTAMENTO:
        return "Departamento";
      case TipoDeDireccion.CONDOMINIO:
        return "Condominio";
      case TipoDeDireccion.RESIDENCIAL:
        return "Residencial";
      case TipoDeDireccion.OFICINA:
        return "Oficina";
      case TipoDeDireccion.LOCAL:
        return "Local";
      case TipoDeDireccion.CENTRO:
        return "Centro";
      case TipoDeDireccion.MERCADO:
        return "Mercado";
      case TipoDeDireccion.GALERIA:
        return "Galeria";
      case TipoDeDireccion.OTRO:
        return "Otro";
      default:
        return null;
    }
  }

  static TipoDeDireccion parse(dynamic data) {
    for (TipoDeDireccion tipoDeDireccion in TipoDeDireccion.values) {
      if (tipoDeDireccion.index == data) {
        return tipoDeDireccion;
      }
    }
    return null;
  }
}
