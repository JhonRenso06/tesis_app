import 'package:mr_yupi/src/api/api.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/delivery.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';

class DeliveryAPI extends API {
  DeliveryAPI() : super('/market/delivery');

  Future<APIResponse<Delivery>> getDelivery(
      Establecimiento establecimiento, Direccion direccion) async {
    var res = await get('', auth: true, query: {
      "establecimiento": establecimiento.id,
      "direccion": direccion.id
    });
    if (res.hasException) {
      return APIResponse.fromResponse(res, null);
    }
    if (!res.hasData) {
      return APIResponse.fromResponse(res, null);
    }
    return APIResponse.fromResponse(res, Delivery().fromMap(res.data));
  }
}
