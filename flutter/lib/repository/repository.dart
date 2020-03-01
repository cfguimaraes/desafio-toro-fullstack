import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toro/repository/sync_socket.dart';

import 'sync_model.dart';

class Repository {
  Database _database;
  final syncSocket = SyncSocket();

  Future<Database> _openDB() async {
    return openDatabase(
        join(
          await getDatabasesPath(),
          "toro1.db",
        ),
        version: 1,
        onCreate: (db, version) => {
              db.execute(
                """
                CREATE TABLE EVENTS (
                  TIMESTAMP TEXT PRIMARY KEY,
                  PAYLOAD TEXT,
                  OPERACAO TEXT,
                  DATA_SINCRONIA TEXT                  
                )
                """,
              ),
            }).then((db) => _database = db);
  }

  _initDb() async {
    if (_database == null) _database = await _openDB();
  }

  Future insertEvent(SyncModel data) async {
    await _initDb();
    await _database.insert("EVENTS", data.toMap());
    this.syncSocket.add(data);
  }
}
