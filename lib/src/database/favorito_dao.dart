import 'package:floor/floor.dart';
import 'package:mr_yupi/src/model/favorito.dart';

@dao
abstract class FavoritoDao {
  @Query('SELECT * FROM Favorito WHERE id = :id')
  Future<Favorito> findFavoritoById(int id);

  @Query('SELECT * FROM Favorito')
  Future<List<Favorito>> findFavoritos();

  @insert
  Future<void> insertFavorito(Favorito favorito);

  @Query('DELETE FROM Favorito WHERE id = :id')
  Future<void> deleteFavorito(int id);
}
