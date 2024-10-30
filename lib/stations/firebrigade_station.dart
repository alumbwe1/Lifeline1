import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline/core/urls.dart';
import '../classes/firebrigade.dart';

import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';
import '../database helpers/firebrigade_model.dart';

class FireBrigadePage extends StatefulWidget {
  FireBrigadePage({Key? key}) : super(key: key);

  @override
  _FireBrigadePageState createState() => _FireBrigadePageState();
}

class _FireBrigadePageState extends State<FireBrigadePage> {
  List<FireBrigade> displayedFirebrigade = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFireBrigadeStations(); // Fetch fire brigade stations when the page is initialized
  }

  // Function to fetch fire brigade stations from the Django server
  Future<void> _fetchFireBrigadeStations() async {
    try {
      // Step 1: Try to fetch cached data
      List<FireBrigade> cachedFirebrigades =
          await FireBrigadeDataHelper.getCachedData();

      if (cachedFirebrigades.isNotEmpty) {
        setState(() {
          displayedFirebrigade = cachedFirebrigades;
        });
      }

      // Step 2: Fetch data from the server
      final response =
          await http.get(Uri.parse(firebrigade));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Step 3: Update state with data from the server
        setState(() {
          displayedFirebrigade =
              data.map((json) => FireBrigade.fromJson(json)).toList();
        });

        // Step 4: Cache the data for offline usage
        await FireBrigadeDataHelper.cacheData(displayedFirebrigade);
      } else {
        // Handle error when fetching from the server
        print('Failed to load fire brigade stations: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general error
      print('Error fetching fire brigade stations: $e');
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
          titleSearch: 'Search for firebrigade stations',
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
      displayedFirebrigade = displayedFirebrigade
          .where((firebrigade) =>
              firebrigade.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedFirebrigade.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedFirebrigade.map((firebrigade) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: firebrigade.name,
                    image: firebrigade.image,
                    phoneNumber: firebrigade.phone_number,
                    onPressed: () {
                      _handleServiceRequest(firebrigade);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(FireBrigade firebrigade) {
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
          location: firebrigade.location,
          name: firebrigade.name,
          phoneNumber: firebrigade.phone_number,
          onPressed: () {
            _showServiceRequestedDialog(firebrigade);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(FireBrigade firebrigade) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${firebrigade.name}.'),
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
