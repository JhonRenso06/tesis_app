// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoritoDao _favoritoDaoInstance;

  ItemCartDao _itemCartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favorito` (`id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemCart` (`id` INTEGER, `cantidad` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoritoDao get favoritoDao {
    return _favoritoDaoInstance ??= _$FavoritoDao(database, changeListener);
  }

  @override
  ItemCartDao get itemCartDao {
    return _itemCartDaoInstance ??= _$ItemCartDao(database, changeListener);
  }
}

class _$FavoritoDao extends FavoritoDao {
  _$FavoritoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favoritoInsertionAdapter = InsertionAdapter(database, 'Favorito',
            (Favorito item) => <String, dynamic>{'id': item.id});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favorito> _favoritoInsertionAdapter;

  @override
  Future<Favorito> findFavoritoById(int id) async {
    return _queryAdapter.query('SELECT * FROM Favorito WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Favorito(row['id'] as int));
  }

  @override
  Future<List<Favorito>> findFavoritos() async {
    return _queryAdapter.queryList('SELECT * FROM Favorito',
        mapper: (Map<String, dynamic> row) => Favorito(row['id'] as int));
  }

  @override
  Future<void> deleteFavorito(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Favorito WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertFavorito(Favorito favorito) async {
    await _favoritoInsertionAdapter.insert(favorito, OnConflictStrategy.abort);
  }
}

class _$ItemCartDao extends ItemCartDao {
  _$ItemCartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _itemCartInsertionAdapter = InsertionAdapter(
            database,
            'ItemCart',
            (ItemCart item) =>
                <String, dynamic>{'id': item.id, 'cantidad': item.cantidad}),
        _itemCartUpdateAdapter = UpdateAdapter(
            database,
            'ItemCart',
            ['id'],
            (ItemCart item) =>
                <String, dynamic>{'id': item.id, 'cantidad': item.cantidad});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemCart> _itemCartInsertionAdapter;

  final UpdateAdapter<ItemCart> _itemCartUpdateAdapter;

  @override
  Future<List<ItemCart>> findItemsCart() async {
    return _queryAdapter.queryList('SELECT * FROM ItemCart',
        mapper: (Map<String, dynamic> row) =>
            ItemCart(row['id'] as int, row['cantidad'] as int));
  }

  @override
  Future<ItemCart> findItemCartById(int id) async {
    return _queryAdapter.query('SELECT * FROM ItemCart WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            ItemCart(row['id'] as int, row['cantidad'] as int));
  }

  @override
  Future<void> deleteItemCart(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM ItemCart WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertItemCart(ItemCart itemCart) async {
    await _itemCartInsertionAdapter.insert(itemCart, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItemCart(ItemCart itemCart) {
    return _itemCartUpdateAdapter.updateAndReturnChangedRows(
        itemCart, OnConflictStrategy.abort);
  }
}
