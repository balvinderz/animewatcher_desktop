// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFavouriteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavouriteDatabaseBuilder databaseBuilder(String name) =>
      _$FavouriteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavouriteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FavouriteDatabaseBuilder(null);
}

class _$FavouriteDatabaseBuilder {
  _$FavouriteDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FavouriteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FavouriteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FavouriteDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$FavouriteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FavouriteDatabase extends FavouriteDatabase {
  _$FavouriteDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavouriteDao _favouriteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `Favourite` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `imageUrl` TEXT, `name` TEXT, `gogoAnimeUrl` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavouriteDao get favouriteDao {
    return _favouriteDaoInstance ??= _$FavouriteDao(database, changeListener);
  }
}

class _$FavouriteDao extends FavouriteDao {
  _$FavouriteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _favouriteInsertionAdapter = InsertionAdapter(
            database,
            'Favourite',
            (Favourite item) => <String, dynamic>{
                  'id': item.id,
                  'imageUrl': item.imageUrl,
                  'name': item.name,
                  'gogoAnimeUrl': item.gogoAnimeUrl
                },
            changeListener),
        _favouriteDeletionAdapter = DeletionAdapter(
            database,
            'Favourite',
            ['id'],
            (Favourite item) => <String, dynamic>{
                  'id': item.id,
                  'imageUrl': item.imageUrl,
                  'name': item.name,
                  'gogoAnimeUrl': item.gogoAnimeUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _favouriteMapper = (Map<String, dynamic> row) => Favourite(
      row['id'] as int,
      row['imageUrl'] as String,
      row['name'] as String,
      row['gogoAnimeUrl'] as String);

  final InsertionAdapter<Favourite> _favouriteInsertionAdapter;

  final DeletionAdapter<Favourite> _favouriteDeletionAdapter;

  @override
  Stream<List<Favourite>> findAnime() {
    return _queryAdapter.queryListStream('SELECT * FROM Favourite',
        queryableName: 'Favourite', isView: false, mapper: _favouriteMapper);
  }

  @override
  Future<Favourite> findFavouriteByName(String name) async {
    return _queryAdapter.query('SELECT * FROM Favourite where name =?',
        arguments: <dynamic>[name], mapper: _favouriteMapper);
  }

  @override
  Future<void> insertFavourite(Favourite favourite) async {
    await _favouriteInsertionAdapter.insert(
        favourite, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFavourite(Favourite favourite) async {
    await _favouriteDeletionAdapter.delete(favourite);
  }
}
