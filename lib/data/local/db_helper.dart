import 'package:factory_monitor/data/model/sensor_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _database;
  String _table = 'sensor';
  int _version = 1;
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  DatabaseHelper._constructor();

  Future<Database> get database async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), "sensors.db"),
        onCreate: (db, version) => _createTable(db),
        onUpgrade: (db, oldVersion, newVersion) {
          db.execute("DROP TABLE IF EXISTS $_table;");
          _createTable(db);
        },
        version: _version,
      );
    }
    return _database;
  }

  Future<void> insert(Sensor sensor) async {
    Database db = await instance.database;
    await db.insert(_table, sensor.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllSensorData(String sensorId) async {
    Database db = await instance.database;

    return (await db.query(_table,
        where: "sensorId = ?", whereArgs: [sensorId], limit: 100));
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: "id = ?", whereArgs: [id]);
  }

  void _createTable(Database db) {
    db.execute(
        "CREATE TABLE $_table(sensorId TEXT, temperature REAL,vibration REAL, time INTEGER, color INTEGER);");
  }
}
