// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Dao _daoInstance;

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
            'CREATE TABLE IF NOT EXISTS `RoomEntity` (`id` TEXT, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemEntity` (`c_id` TEXT, `c_field_name` TEXT, `density` TEXT, `owner_id` TEXT, FOREIGN KEY (`owner_id`) REFERENCES `RoomEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`c_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AddedEntity` (`c_id` TEXT, `c_field_name` TEXT, `density` TEXT, `owner_id` TEXT, `qty` TEXT, `name` TEXT, FOREIGN KEY (`owner_id`) REFERENCES `RoomEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`c_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Dao get dao {
    return _daoInstance ??= _$Dao(database, changeListener);
  }
}

class _$Dao extends Dao {
  _$Dao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _roomEntityMapper = (Map<String, dynamic> row) =>
      RoomEntity(row['id'] as String, row['name'] as String);

  static final _itemEntityMapper = (Map<String, dynamic> row) => ItemEntity(
      row['c_id'] as String,
      row['c_field_name'] as String,
      row['density'] as String,
      row['owner_id'] as String);

  static final _addedEntityMapper = (Map<String, dynamic> row) => AddedEntity(
      row['c_id'] as String,
      row['c_field_name'] as String,
      row['density'] as String,
      row['owner_id'] as String,
      row['qty'] as String,
      row['name'] as String);

  @override
  Future<List<RoomEntity>> allRooms() async {
    return _queryAdapter.queryList('SELECT * FROM RoomEntity',
        mapper: _roomEntityMapper);
  }

  @override
  Future<List<ItemEntity>> allItems() async {
    return _queryAdapter.queryList('SELECT * FROM ItemEntity',
        mapper: _itemEntityMapper);
  }

  @override
  Future<List<AddedEntity>> allAddedItems() async {
    return _queryAdapter.queryList('SELECT * FROM AddedEntity',
        mapper: _addedEntityMapper);
  }

  @override
  Future<List<ItemEntity>> findItemsById(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ItemEntity WHERE owner_id = ?',
        arguments: <dynamic>[id],
        mapper: _itemEntityMapper);
  }

  @override
  Future<void> insertItemEntity(
      String c_id, String c_field_name, String density, String owner_id) async {
    await _queryAdapter.queryNoReturn(
        'INSERT or IGNORE into ItemEntity VALUES (?,?,?,?)',
        arguments: <dynamic>[c_id, c_field_name, density, owner_id]);
  }

  @override
  Future<void> insertAddedItemEntity(String c_id, String c_field_name,
      String density, String owner_id, String qty, String name) async {
    await _queryAdapter.queryNoReturn(
        'INSERT or REPLACE into AddedEntity VALUES (?,?,?,?,?,?)',
        arguments: <dynamic>[c_id, c_field_name, density, owner_id, qty, name]);
  }

  @override
  Future<void> insertRoomEntity(String id, String name) async {
    await _queryAdapter.queryNoReturn(
        'INSERT or IGNORE into RoomEntity VALUES (?,?)',
        arguments: <dynamic>[id, name]);
  }

  @override
  Future<void> clearAddedItemEntity() async {
    await _queryAdapter.queryNoReturn('DELETE FROM AddedEntity');
  }
}
