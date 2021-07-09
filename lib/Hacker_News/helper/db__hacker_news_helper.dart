import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/hacker_news_story_model.dart';
import '../repositories/abstract_data_scource_caches.dart';

class HackerNewsDb implements DataSource, Cache {
  static Database? _dataBase;
  static const String hackerNewsStoriesTable = "news";
  static const String _dataBaseName = "hacker_news.db";
  static const String id = "id";
  static const String descendants = "descendants";
  static const String by = "by";
  static const String score = "score";
  static const String time = "time";
  static const String title = "title";
  static const String type = "type";
  static const String url = "url";
  static const String kids = "kids";

  //constructor return _instance
  factory HackerNewsDb() {
    return _instance;
  }
  //named constructor return
  HackerNewsDb._internal() {
    // _initDB();
  }
  // only one instance of our class
  static final HackerNewsDb _instance = HackerNewsDb._internal();

  Future<Database> get _getDataBase => _initDB();

  Future<Database> _initDB() async {
    //return a referance on the phone
    //where you can safely store your data permentaly on your device
    if (_dataBase != null) return _dataBase!;
    final Directory _directory = await getApplicationDocumentsDirectory();
    final String _path = join(_directory.path, _dataBaseName);
    _dataBase = await openDatabase(_path, version: 1,
        onCreate: (Database newDataBase, int version) {
      newDataBase.execute("""
        
        CREATE TABLE $hackerNewsStoriesTable(
   $id          INTEGER NOT NULL PRIMARY KEY
  ,$descendants INTEGER  
  ,$by          TEXT
  ,$score       INTEGER  
  ,$time        INTEGER  
  ,$title       TEXT 
  ,$type        TEXT 
  ,$url         TEXT
  ,$kids        BLOB );
         
          """);
    });

    return _dataBase!;
  }

  @override
  Future<HackerNewsStory?> fetchStoryById(int id) async {
    final Database _db = await _getDataBase;
    final List<Map<String, Object?>> maps =
        await _db.query(hackerNewsStoriesTable,
            columns: null, // to get all columns
            where: "id = ?",
            whereArgs: <int>[id]);

    return maps.isNotEmpty ? HackerNewsStory.fromDB(maps.first) : null;
  }

  @override
  Future<bool> addItem(HackerNewsStory item) async {
    final Database _db = await _getDataBase;
    try {
      await _db.insert(hackerNewsStoriesTable, item.toMapForDB(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<int>?> getTopStoriesIds() async {
    final Database _db = await _getDataBase;
    final List<Map<String, Object?>> idMap =
        await _db.query(hackerNewsStoriesTable, columns: <String>[id]);

    final List<int> returnedMap =
        idMap.map((Map<String, Object?> e) => e.values.first as int).toList();
    // ignore: avoid_print
    print(returnedMap);
    return idMap.isNotEmpty ? returnedMap : null;
  }

  @override
  Future<int> clearCache() async {
    final Database _db = await _getDataBase;
    return _db.delete(hackerNewsStoriesTable);
  }
}
