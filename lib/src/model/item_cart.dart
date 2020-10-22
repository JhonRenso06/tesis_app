import 'package:floor/floor.dart';

@entity
class ItemCart {
  @PrimaryKey(autoGenerate: false)
  final int id;

  final int cantidad;

  ItemCart(this.id, this.cantidad);
}
