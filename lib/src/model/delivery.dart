import 'package:mr_yupi/src/model/model.dart';

class Delivery extends Model {
  num id;
  num monto;

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.monto = double.parse(data["monto"]);
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {"monto": this.monto, "id": this.id};
  }
}
