enum MetodoDeEnvio {
  A_DOMICILIO,
  EN_TIENDA,
}

extension MetodoDeEnvioExtension on MetodoDeEnvio {
  String get name {
    switch (this) {
      case MetodoDeEnvio.A_DOMICILIO:
        return "A domicilio";
      case MetodoDeEnvio.EN_TIENDA:
        return "En tienda";
      default:
        return null;
    }
  }

  static MetodoDeEnvio parse(dynamic data) {
    for (MetodoDeEnvio metodoDeEnvio in MetodoDeEnvio.values) {
      if (metodoDeEnvio.index == data) {
        return metodoDeEnvio;
      }
    }
    return null;
  }
}
