import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Databasehelper{
  static final _databasename = "MyData";
  static final _databaseversion = 1;
  static final table = "MyTable";
  final title;
  final content;
  static Database _database;

  Databasehelper({this.title, this.content});

  Future<Database> get database async{
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path, version: _databaseversion,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute(
      '''
      CREATE TABLE MyData (
      title TEXT PRIMARY KEY,
      content TEXT NOT NULL
      )
      '''
    );
  }

  Future<void> insertData(Databasehelper MyTable) async {
    final Database db = await database;
    await db.insert(
      'MyData',
      MyTable.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, String> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }

  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");
    return result.toList();
  }
}