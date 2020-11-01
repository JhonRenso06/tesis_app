import 'package:mr_yupi/src/api/delivery_api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/delivery.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';

class DeliveryRepository {
  DeliveryAPI _deliveryAPI;

  DeliveryRepository() {
    _deliveryAPI = DeliveryAPI();
  }

  Future<APIResponse<Delivery>> getDelivery(
      Establecimiento establecimiento, Direccion direccion) async {
    return await _deliveryAPI.getDelivery(establecimiento, direccion);
  }
}
