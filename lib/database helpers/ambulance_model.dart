import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/ambulance.dart';

class AmbulanceDataHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'ambulance_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ambulance_stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          phone_number TEXT,
          location TEXT
        )
      ''');
    });
  }

  static Future<void> cacheData(List<Ambulance> ambulances) async {
    try {
      final Database db = await _getDatabase();
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM ambulance_stations');
        for (final ambulance in ambulances) {
          await txn.rawInsert('''
            INSERT INTO ambulance_stations (name, image, phone_number, location)
            VALUES (?, ?, ?, ?)
          ''', [
            ambulance.name,
            ambulance.image,
            ambulance.phone_number,
            ambulance.location
          ]);
        }
      });
    } catch (e) {
      print('Error caching ambulance data: $e');
    }
  }

  static Future<List<Ambulance>> getCachedData() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> results =
          await db.query('ambulance_stations');
      return results.map((map) => Ambulance.fromJson(map)).toList();
    } catch (e) {
      print('Error retrieving cached ambulance data: $e');
      return [];
    }
  }

  static Future<List<Ambulance>> fetchAmbulanceStations() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/ambulance/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Ambulance.fromJson(json)).toList();
      } else {
        print('Failed to load ambulance stations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching ambulance stations: $e');
      return [];
    }
  }
}
