import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/delivery.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/resources/delivery_repository.dart';

class DeliveryBloc extends Cubit<APIResponse<Delivery>> {
  DeliveryRepository _repository;

  DeliveryBloc() : super(APIResponse<Delivery>()) {
    _repository = DeliveryRepository();
  }

  getDelivery(Establecimiento establecimiento, Direccion direccion) async {
    emit(state.toLoading());
    var result = await _repository.getDelivery(establecimiento, direccion);
    emit(result);
  }
}
