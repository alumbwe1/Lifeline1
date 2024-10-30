// data_helpers/data_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../classes/police.dart';
import '../../core/urls.dart';

class DataHelper {
  static Future<List<Police>> getCachedData() async {
    // Implement your caching logic here
    return [];
  }

  static Future<void> cacheData(List<Police> data) async {
    // Implement your caching logic here
  }

  static Future<List<Police>> fetchPoliceStations() async {
    try {
      List<Police> cachedStations = await getCachedData();

      if (cachedStations.isNotEmpty) {
        return cachedStations;
      }

      final response = await http.get(Uri.parse(police));

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
