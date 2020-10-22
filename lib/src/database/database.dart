import 'dart:async';
import 'package:floor/floor.dart';
import 'package:mr_yupi/src/database/item_cart_dao.dart';
import 'package:mr_yupi/src/model/item_cart.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:mr_yupi/src/database/favorito_dao.dart';
import 'package:mr_yupi/src/model/favorito.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Favorito, ItemCart])
abstract class FlutterDatabase extends FloorDatabase {
  FavoritoDao get favoritoDao;

  ItemCartDao get itemCartDao;
}
