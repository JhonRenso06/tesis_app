enum Moneda {
  SOLES,
  DOLARES,
}

extension MonedaExtension on Moneda {
  String get name {
    switch (this) {
      case Moneda.SOLES:
        return "Soles";
      case Moneda.DOLARES:
        return "Dolares";
      default:
        return null;
    }
  }

  static Moneda parse(dynamic data) {
    for (Moneda moneda in Moneda.values) {
      if (moneda.index == data) {
        return moneda;
      }
    }
    return null;
  }
}
