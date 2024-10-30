import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/firebrigade.dart';

class FireBrigadeDataHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'firebrigade_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS firebrigade_stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          phone_number TEXT,
          location TEXT
        )
      ''');
    });
  }

  static Future<void> cacheData(List<FireBrigade> firebrigades) async {
    try {
      final Database db = await _getDatabase();
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM firebrigade_stations');
        for (final firebrigade in firebrigades) {
          await txn.rawInsert('''
            INSERT INTO firebrigade_stations (name, image, phone_number, location)
            VALUES (?, ?, ?, ?)
          ''', [
            firebrigade.name,
            firebrigade.image,
            firebrigade.phone_number,
            firebrigade.location
          ]);
        }
      });
    } catch (e) {
      print('Error caching fire brigade data: $e');
    }
  }

  static Future<List<FireBrigade>> getCachedData() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> results =
          await db.query('firebrigade_stations');
      return results.map((map) => FireBrigade.fromJson(map)).toList();
    } catch (e) {
      print('Error retrieving cached fire brigade data: $e');
      return [];
    }
  }

  static Future<List<FireBrigade>> fetchFireBrigadeStations() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/firebrigade/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => FireBrigade.fromJson(json)).toList();
      } else {
        print('Failed to load fire brigade stations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching fire brigade stations: $e');
      return [];
    }
  }
}
