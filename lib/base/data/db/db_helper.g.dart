// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_helper.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorDatabaseHelper {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseHelperBuilder databaseBuilder(String name) =>
      _$DatabaseHelperBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseHelperBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseHelperBuilder(null);
}

class _$DatabaseHelperBuilder {
  _$DatabaseHelperBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DatabaseHelperBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseHelperBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseHelper> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseHelper();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseHelper extends DatabaseHelper {
  _$DatabaseHelper([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppDao? _appDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `Bill` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `date` INTEGER, `money` INTEGER, `monthId` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BillByMonth` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `month` INTEGER, `surplus` INTEGER NOT NULL, `paid` INTEGER NOT NULL, `userId` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT, `imageUrl` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppDao get appDao {
    return _appDaoInstance ??= _$AppDao(database, changeListener);
  }
}

class _$AppDao extends AppDao {
  _$AppDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _billInsertionAdapter = InsertionAdapter(
            database,
            'Bill',
            (Bill item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'money': item.money,
                  'monthId': item.monthId
                }),
        _billByMonthInsertionAdapter = InsertionAdapter(
            database,
            'BillByMonth',
            (BillByMonth item) => <String, Object?>{
                  'id': item.id,
                  'month': item.month,
                  'surplus': item.surplus,
                  'paid': item.paid,
                  'userId': item.userId
                }),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'imageUrl': item.imageUrl
                }),
        _billByMonthUpdateAdapter = UpdateAdapter(
            database,
            'BillByMonth',
            ['id'],
            (BillByMonth item) => <String, Object?>{
                  'id': item.id,
                  'month': item.month,
                  'surplus': item.surplus,
                  'paid': item.paid,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bill> _billInsertionAdapter;

  final InsertionAdapter<BillByMonth> _billByMonthInsertionAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<BillByMonth> _billByMonthUpdateAdapter;

  @override
  Future<List<Bill>> getAllBills() async {
    return _queryAdapter.queryList('SELECT * FROM Bill',
        mapper: (Map<String, Object?> row) => Bill(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as int?,
            money: row['money'] as int?,
            monthId: row['monthId'] as int?));
  }

  @override
  Future<List<Bill>> getBillsByMonth(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Bill WHERE monthId = ?1',
        mapper: (Map<String, Object?> row) => Bill(
            id: row['id'] as int?,
            name: row['name'] as String?,
            date: row['date'] as int?,
            money: row['money'] as int?,
            monthId: row['monthId'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<BillByMonth>> getBillOfMonth(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM BillByMonth WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => BillByMonth(
            id: row['id'] as int?,
            surplus: row['surplus'] as int,
            paid: row['paid'] as int,
            month: row['month'] as int?,
            userId: row['userId'] as int?),
        arguments: [userId]);
  }

  @override
  Future<BillByMonth?> getBillByMonth(int month, int userId) async {
    return _queryAdapter.query(
        'SELECT * FROM BillByMonth WHERE month = ?1 AND userId = ?2',
        mapper: (Map<String, Object?> row) => BillByMonth(
            id: row['id'] as int?,
            surplus: row['surplus'] as int,
            paid: row['paid'] as int,
            month: row['month'] as int?,
            userId: row['userId'] as int?),
        arguments: [month, userId]);
  }

  @override
  Future<List<User>> getUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int?,
            userName: row['userName'] as String?,
            imageUrl: row['imageUrl'] as String?));
  }

  @override
  Future<void> insertBill(Bill bill) async {
    await _billInsertionAdapter.insert(bill, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertBillOfMonth(BillByMonth bill) async {
    await _billByMonthInsertionAdapter.insert(bill, OnConflictStrategy.abort);
  }

  @override
  Future<void> saveUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBillOfMonth(BillByMonth bom) async {
    await _billByMonthUpdateAdapter.update(bom, OnConflictStrategy.abort);
  }
}
