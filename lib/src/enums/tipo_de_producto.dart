enum TipoDeProducto {
  PRODUCTO,
  COMBO,
  SERVICIO,
}

extension TipoDeProductoExtension on TipoDeProducto {
  String get name {
    switch (this) {
      case TipoDeProducto.PRODUCTO:
        return "Producto";
      case TipoDeProducto.COMBO:
        return "Combo";
      case TipoDeProducto.SERVICIO:
        return "Servicio";
      default:
        return null;
    }
  }

  static TipoDeProducto parse(dynamic data) {
    for (TipoDeProducto tipoDeProducto in TipoDeProducto.values) {
      if (tipoDeProducto.index == data) {
        return tipoDeProducto;
      }
    }
    return null;
  }
}
