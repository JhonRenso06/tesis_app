import 'package:floor/floor.dart';

@entity
class Favorito {
  @PrimaryKey(autoGenerate: false)
  final int id;

  Favorito(this.id);
}
