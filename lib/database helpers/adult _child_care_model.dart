import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/adult_child_care.dart';

class AdultChildCareDataHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'adult_child_care_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS adult_child_care (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          phone_number TEXT,
          location TEXT
        )
      ''');
    });
  }

  static Future<void> cacheData(List<AdultChildCare> stations) async {
    try {
      final Database db = await _getDatabase();
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM adult_child_care');
        for (final station in stations) {
          await txn.rawInsert('''
            INSERT INTO adult_child_care (name, image, phone_number, location)
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
      print('Error caching adult child care data: $e');
    }
  }

  static Future<List<AdultChildCare>> getCachedData() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> results =
          await db.query('adult_child_care');
      return results.map((map) => AdultChildCare.fromJson(map)).toList();
    } catch (e) {
      print('Error retrieving cached adult child care data: $e');
      return [];
    }
  }

  static Future<List<AdultChildCare>> fetchAdultChildCareStations() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/adultchildcare/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => AdultChildCare.fromJson(json)).toList();
      } else {
        print(
            'Failed to load adult child care stations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching adult child care stations: $e');
      return [];
    }
  }
}
