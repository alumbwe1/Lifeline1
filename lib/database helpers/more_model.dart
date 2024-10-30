import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/more.dart';

class MoreDataHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'more_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS more_services (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          image TEXT,
          phone_number TEXT,
          location TEXT
        )
      ''');
    });
  }

  static Future<void> cacheData(List<More> moreServices) async {
    try {
      final Database db = await _getDatabase();
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM more_services');
        for (final moreService in moreServices) {
          await txn.rawInsert('''
            INSERT INTO more_services (name, image, phone_number, location)
            VALUES (?, ?, ?, ?)
          ''', [
            moreService.name,
            moreService.image,
            moreService.phone_number,
            moreService.location
          ]);
        }
      });
    } catch (e) {
      print('Error caching more services data: $e');
    }
  }

  static Future<List<More>> getCachedData() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> results =
          await db.query('more_services');
      return results.map((map) => More.fromJson(map)).toList();
    } catch (e) {
      print('Error retrieving cached more services data: $e');
      return [];
    }
  }

  static Future<List<More>> fetchMoreServices() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/more/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => More.fromJson(json)).toList();
      } else {
        print('Failed to load more services: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching more services: $e');
      return [];
    }
  }
}
