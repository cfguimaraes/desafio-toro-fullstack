import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'sync_model.dart';

class Repository {
  Database _database;
  Repository() {}

  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), "toro.db"),
        onCreate: (db, version) => {
              db.execute(
                """
                CREATE TABLE EVENTS (
                  TIMESTAMP TEXT PRIMARY KEY,
                  PAYLOAD TEXT,
                  DATE_SYNCED TEXT                  
                )
                """,
              ),
            }).then((db) => _database = db);
  }

  Future insertEvent(SyncModel data) async {
    Database db = await _openDB();
    await db.insert("EVENTS", data.toMap());
  }
}
