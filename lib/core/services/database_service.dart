import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/core/helpers/db_migrator.dart';

class PingnaDB {
  static Database _db;

  // If there is no database in place then initialise one
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    // Initialise db
    _db = await initDb();
    return _db;
  }

  // Set up the database and assign it a version number
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");

    int latestVersion = PingnaDBMigrator.latestVersion;

    return await openDatabase(
      path,
      version: latestVersion,
      onCreate: createDB,
      onUpgrade: upgradeDB,
    );
  }

  Future<int> getCurrentDbVersion(Database db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]["user_version"].toString();
    return int.parse(version);
  }

  Future<void> upgradeDbVersion(Database db, int version) async {
    await db.rawQuery("pragma user_version = $version;");
  }

  // Create the database / first migration containing a basic users table
  Future createDB(Database db, int _) async {
    // Run all migrations if this is the first time creating the database
    final migrations = PingnaDBMigrator.migrations;
    migrations.keys.toList()
      ..sort()
      ..forEach((k) async {
        var script = migrations[k];
        await db.execute(script);
      });
  }

  Future upgradeDB(Database db, int _, int __) async {
    //get the version of current database
    int latestVersion = PingnaDBMigrator.latestVersion;
    int currentVersion = await getCurrentDbVersion(db);
    print("Local DB at version $currentVersion | Upgrading to $latestVersion");

    //get only those migration scripts after the currentVersion
    final migrations = PingnaDBMigrator.migrations;
    Map upgradeScripts = Map.fromIterable(
      migrations.keys.where((k) => k > currentVersion),
      key: (k) => k,
      value: (k) => migrations[k],
    );

    if (upgradeScripts.length == 0) return;

    upgradeScripts.keys.toList()
      ..sort()
      ..forEach((k) async {
        var script = upgradeScripts[k];
        await db.execute(script);
      });

    //once all scripts are run, we need to make sure database version is updated
    upgradeDbVersion(db, latestVersion);
  }

  // Database methods //
  Future<void> drop(String table) async {
    Database database = await db;
    return await database.execute('DROP TABLE IF EXISTS "$table"');
  }

  Future<List<Map>> query(String sql, List args) async {
    Database database = await db;
    return await database.rawQuery(sql, args);
  }

  Future<List<Map>> selectWhere(
    String table, {
    List<String> columns,
    String where,
    List whereArgs,
    String orderBy,
    int limit,
    bool distinct = false,
  }) async {
    Database database = await db;

    return await database.query(
      table,
      columns: columns != null ? columns : ['*'],
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      distinct: distinct,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    Database database = await db;
    return await database.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String where,
    List whereArgs,
  }) async {
    Database database = await db;
    return await database.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    ); //the id
  }

  Future<int> insertOrUpdate(String table, Map<String, dynamic> values,
      {String where, List whereArgs}) async {
    List<Map> item;
    if (whereArgs.where((item) => item != null).toList().length > 0) {
      item = await selectWhere(table, where: where, whereArgs: whereArgs);
    }

    values.remove("id");
    if (item != null && item.length > 0) {
      // Update the record
      await update(
        table,
        values,
        where: '$colId = ?',
        whereArgs: [item.first["id"]],
      );
      return item.first["id"];
    } else {
      // Insert a new record
      return await insert(table, values);
    }
  }

  Future<int> delete(String table, {String where, List whereArgs}) async {
    Database database = await db;
    return await database.delete(table,
        where: where, whereArgs: whereArgs); //the id
  }

  Future<int> deleteAll(String table) async {
    var dbClient = await db;
    int res = await dbClient.delete(table, where: '1 = 1');
    return res;
  }

  Future<int> count(String table, {String where, List whereArgs}) async {
    Database database = await db;

    String w = "";
    if (where != null) w = w + where;

    List wA = [];
    if (whereArgs != null) wA = wA + whereArgs;

    final count = ['COUNT(*) as count'];
    return await database
        .query(table, distinct: true, columns: count, where: w, whereArgs: wA)
        .then((res) => res.first["count"]);
  }
  // table specific helper methods //

  Future<List<T>> list<T>(
    String list, {
    String where,
    List whereArgs,
    String orderBy,
    bool orderDesc = false,
    int limit,
  }) async {
    String w = "";
    if (where != null) {
      w = w + " AND " + where;
    }

    List wA = [];
    if (whereArgs != null) {
      wA = wA + whereArgs;
    }

    String order = orderBy ?? "$colId";
    String desc = orderDesc ? " DESC " : " ASC ";

    List<Map> res = await selectWhere(
      list,
      where: w,
      whereArgs: wA,
      orderBy: order + desc,
      limit: limit,
    );

    return List<T>.from(res.toList());
  }
}
