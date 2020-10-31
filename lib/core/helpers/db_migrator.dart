import 'dart:math' as math;

import 'package:pingna/core/constants.dart';

class PingnaDBMigrator {
  static final int latestVersion = migrations.keys.reduce(math.max);

  /// Each key represents a new version number, these keys must be integers and
  /// increment by 1 each time.
  static final Map<int, String> migrations = {
    1: '''
      CREATE TABLE IF NOT EXISTS $shopTypesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT
      )''',
    2: '''
      CREATE TABLE IF NOT EXISTS $shopsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colShopTypeId INTEGER,
        $colName TEXT,
        $colDescription TEXT,
        $colImageUrl TEXT,
        $colLabelIds TEXT,
      )''',
    3: '''
      CREATE TABLE IF NOT EXISTS $shopLabelsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
      )''',
    4: '''
      CREATE TABLE IF NOT EXISTS $productTypesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colShopId INTEGER,
        $colName TEXT,
      )''',
    5: '''
      CREATE TABLE IF NOT EXISTS $productsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colProductTypeId INTEGER,
        $colName TEXT,
        $colImageUrl TEXT,
        $colPrice INTEGER,
        $colReducedBy INTEGER,
      )''',
    6: '''
      CREATE TABLE IF NOT EXISTS $productsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colProductTypeId INTEGER,
        $colName TEXT,
        $colImageUrl TEXT,
        $colPrice INTEGER,
        $colReducedBy INTEGER,
        $colStatus TEXT,
        $colExpiresAt TEXT,
      )''',
    7: '''
      CREATE TABLE IF NOT EXISTS $basketsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colUserId INTEGER,
        $colShopId INTEGER,
        $colStatus TEXT,
        $colCreatedAt TEXT,
        $colUpdatedAt TEXT,
      )''',
    8: '''
      CREATE TABLE IF NOT EXISTS $basketProductsTable (
        $colBasketId INTEGER,
        $colProductId INTEGER,
        $colQuantity INTEGER,
      )''',
  };
}
