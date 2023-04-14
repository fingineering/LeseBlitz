import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:worte_lesen/models.dart';

// Functiion to create the initial database
_onCreate(Database db, int version) async {
  await db.execute("""CREATE TABLE LeseConfig (
      id INTEGER PRIMARY KEY,
      name TEXT DEFAULT 'default',
      backgroundColor TEXT DEFAULT 'F8FFFF',
      textColor TEXT DEFAULT '000000',
      vowelColor TEXT DEFAULT '0E93E0',
      fontSize INTEGER DEFAULT 160,
      font TEXT DEFAULT 'SF Pro Display',
      delay INTEGER DEFAULT 700,
      showSeparator INTEGER DEFAULT 0,
      highlightVowel INTEGER DEFAULT 0,
      randomWordOrder  INTEGER DEFAULT 0,
      maximumWords INTEGER DEFAULT 15,
      countWords INTEGER DEFAULT 0,
      wordSet INTEGER DEFAULT 1
    );""");
  await db.execute(
      "CREATE TABLE Words (id INTEGER PRIMARY KEY, setId INTEGER NULL, word TEXT NOT NULL, partialWord TEXT NOT NULL)");

  await db.execute(
      "CREATE TABLE WordSet (id INTEGER PRIMARY KEY, name TEXT NOT NULL DEFAULT 'default', level INTEGER DEFAULT 1)");
}

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print('db location: ' + path);
    return openDatabase(join(path, 'leseblitz.db'),
        onCreate: _onCreate, version: 1);
  }

  // get words from  db from word set
  Future<List<String>> getWordsForSet() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResults = await db.query('Words');
    return queryResults.map((e) => Word.fromMap(e).toString()).toList();
  }

  // get the configuration from the database
  Future<LeseConfig> getConfiguration({String configName = "default"}) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db
        .query('LeseConfig', where: 'name  LIKE ?', whereArgs: [configName]);
    Map<String, dynamic> config = queryResults.first;
    return LeseConfig.fromMap(config);
  }
}
