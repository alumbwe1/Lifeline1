import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/police.dart';

class DataHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'stations_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          phone_number TEXT,
          location TEXT
        )
      ''');
    });
  }

  static Future<void> cacheData(List<Police> stations) async {
    try {
      final Database db = await _getDatabase();
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM stations');
        for (final station in stations) {
          await txn.rawInsert('''
            INSERT INTO stations (name, image, phone_number, location)
            VALUES (?, ?, ?, ?)
          ''', [
            station.name,
            station.image,
            station.phone_number,
            station.location
          ]);
        }
      });
    } catch (e) {
      print('Error caching data: $e');
    }
  }

  static Future<List<Police>> getCachedData() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> results = await db.query('stations');
      return results.map((map) => Police.fromJson(map)).toList();
    } catch (e) {
      print('Error retrieving cached data: $e');
      return [];
    }
  }

  static Future<List<Police>> fetchPoliceStations() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/police/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Police.fromJson(json)).toList();
      } else {
        print('Failed to load police stations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching police stations: $e');
      return [];
    }
  }
}
