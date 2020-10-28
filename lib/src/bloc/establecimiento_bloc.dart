import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/resources/establecimiento_repository.dart';

class EstablecimientoBloc extends Cubit<Establecimiento> {
  EstablecimientoRepository _repository;

  List<Departamento> departamentos;
  bool defaultSelected;

  EstablecimientoBloc() : super(null) {
    defaultSelected = false;
    _repository = EstablecimientoRepository();
  }

  initialLoad() async {
    emit(null);
    departamentos = (await _repository.initialLoad()).data.items;
    defaultSelected = true;
    emit(selectDefault());
  }

  Establecimiento selectDefault() {
    if (departamentos != null) {
      if (departamentos.length > 0) {
        if (departamentos[0].provincias.length > 0) {
          if (departamentos[0].provincias[0].establecimientos.length > 0) {
            return departamentos[0].provincias[0].establecimientos[0];
          }
        }
      }
    }

    return null;
  }

  set establecimiento(Establecimiento establecimiento) {
    defaultSelected = false;
    emit(establecimiento);
  }

  int get establecimientosSize {
    if (departamentos == null) {
      return 0;
    }
    int count = 0;
    departamentos.forEach((dep) {
      dep.provincias.forEach((prov) {
        count += prov.establecimientos.length;
      });
    });
    return count;
  }
}
