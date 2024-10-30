import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lifeline/core/urls.dart';
import '../classes/ambulance.dart';

import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';
import '../database helpers/ambulance_model.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({Key? key}) : super(key: key);

  @override
  _AmbulancePageState createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  List<Ambulance> displayedAmbulance = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAmbulanceStations(); // Fetch ambulance stations when the page is initialized
  }

  Future<void> _fetchAmbulanceStations() async {
    try {
      List<Ambulance> cachedAmbulances =
          await AmbulanceDataHelper.getCachedData();

      if (cachedAmbulances.isNotEmpty) {
        setState(() {
          displayedAmbulance = cachedAmbulances;
        });
      }

      final response =
          await http.get(Uri.parse(ambulance));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          displayedAmbulance =
              data.map((json) => Ambulance.fromJson(json)).toList();
        });

        // Cache the data for offline usage
        await AmbulanceDataHelper.cacheData(displayedAmbulance);
      } else {
        print('Failed to load ambulance stations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching ambulance stations: $e');
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
          titleSearch: 'Search for Ambulance stations',
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,

      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
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
      displayedAmbulance = displayedAmbulance
          .where((ambulance) =>
              ambulance.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedAmbulance.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedAmbulance.map((ambulance) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: ambulance.name,
                    image: ambulance.image,
                    phoneNumber: ambulance.phone_number,
                    onPressed: () {
                      _handleServiceRequest(ambulance);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(Ambulance ambulance) {
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
          name: ambulance.name,
          location: ambulance.location,
          phoneNumber: ambulance.phone_number,
          onPressed: () {
            _showServiceRequestedDialog(ambulance);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(Ambulance ambulance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${ambulance.name}.'),
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
