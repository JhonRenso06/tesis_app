import 'package:floor/floor.dart';
import 'package:mr_yupi/src/model/item_cart.dart';

@dao
abstract class ItemCartDao {
  @Query('SELECT * FROM ItemCart')
  Future<List<ItemCart>> findItemsCart();

  @Query('SELECT * FROM ItemCart WHERE id = :id')
  Future<ItemCart> findItemCartById(int id);

  @insert
  Future<void> insertItemCart(ItemCart itemCart);

  @update
  Future<int> updateItemCart(ItemCart itemCart);

  @Query('DELETE FROM ItemCart WHERE id = :id')
  Future<void> deleteItemCart(int id);
}
