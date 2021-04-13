import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Databasehelper{
  static final _databasename = "MyData";
  static final _databaseversion = 1;
  static final table = "MyTable";
  static final title = 'title';
  static final content = 'content';
  static Database _database;

  Databasehelper._privateConstructor({title, content});
  static final Databasehelper instance = Databasehelper._privateConstructor();

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
      CREATE TABLE $table ($title TEXT PRIMARY KEY,$content TEXT NOT NULL)
      '''
    );
  }

  Future<void> insertData(String head,String body) async {
    Database db = await instance.database;
    db.rawInsert(
        'INSERT INTO $table'
            '($title, $content) '
            'VALUES(?,?)', [head, body]);
  }

  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await instance.database;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");
    print (result.toList());
    return result.toList();
  }

  Future<void> deleteData(String heading) async {
    final db = await instance.database;
    await db.delete(table, where: "title = ?", whereArgs: [heading],);
  }

  Future<List> queryAll() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Databasehelper._privateConstructor(
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }
}