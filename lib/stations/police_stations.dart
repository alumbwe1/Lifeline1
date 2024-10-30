import 'dart:convert';
import 'package:flutter/material.dart';
import '../classes/police.dart';
import '../database helpers/police_model.dart';
import 'package:http/http.dart' as http;

import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';
import '../core/urls.dart';
import '../features/screens/report_screen.dart'; // Import 'police' from your core/urls.dart

class StationsPage extends StatefulWidget {
  StationsPage({Key? key}) : super(key: key);

  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  List<Police> displayedStations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPoliceStations();
  }

  Future<void> _fetchPoliceStations() async {
    List<Police> cachedStations = await DataHelper.getCachedData();

    if (cachedStations.isNotEmpty) {
      setState(() {
        displayedStations = cachedStations;
      });
    }

    final response = await http.get(Uri.parse(police));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        displayedStations = data.map((json) => Police.fromJson(json)).toList();
      });

      // Cache the data for offline usage
      await DataHelper.cacheData(displayedStations);
    } else {
      print('Failed to load police stations: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        CustomSearchBar.SearchBar(
          controller: _searchController,
          onSearch: _search,
          titleSearch: 'Search for Police stations',
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: _buildStationList(),
          ),

        ],
      ),
    );
  }

  void _search(String query) {
    setState(() {
      displayedStations = displayedStations
          .where((station) =>
              station.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: displayedStations.isEmpty
              ? [
                  const SizedBox(height: 16),
                  const Text('No results found'),
                ]
              : displayedStations.map((station) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomStationCard(
                      name: station.name,
                      image: station.image,
                      phoneNumber: station.phone_number,
                      onPressed: () {
                        _handleServiceRequest(station);
                      },
                    ),
                  );
                }).toList(),
        ),
      ),
    );
  }

  void _handleServiceRequest(Police station) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (BuildContext context) {
        return ServiceRequestBottomSheet(
          location: station.location,
          phoneNumber: station.phone_number,
          name: station.name,
          onPressed: () {
            _showServiceRequestedDialog(station);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(Police station) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${station.name}.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
