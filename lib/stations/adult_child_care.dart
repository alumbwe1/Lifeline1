import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline/core/urls.dart';
import '../classes/adult_child_care.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';
import '../database helpers/adult _child_care_model.dart';

class AdultChildCarePage extends StatefulWidget {
  const AdultChildCarePage({Key? key}) : super(key: key);

  @override
  _AdultChildCarePageState createState() => _AdultChildCarePageState();
}

class _AdultChildCarePageState extends State<AdultChildCarePage> {
  List<AdultChildCare> displayedAdultChildCare = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAdultChildCareStations(); // Fetch adult child care stations when the page is initialized
  }

  // Function to fetch adult child care stations from the Django server
  Future<void> _fetchAdultChildCareStations() async {
    try {
      // Step 1: Try to fetch cached data
      List<AdultChildCare> cachedAdultChildCare =
          await AdultChildCareDataHelper.getCachedData();

      if (cachedAdultChildCare.isNotEmpty) {
        setState(() {
          displayedAdultChildCare = cachedAdultChildCare;
        });
      }

      // Step 2: Fetch data from the server
      final response =
          await http.get(Uri.parse(adultchildcare));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Step 3: Update state with data from the server
        setState(() {
          displayedAdultChildCare =
              data.map((json) => AdultChildCare.fromJson(json)).toList();
        });

        // Step 4: Cache the data for offline usage
        await AdultChildCareDataHelper.cacheData(displayedAdultChildCare);
      } else {
        // Handle error when fetching from the server
        print(
            'Failed to load adult child care stations: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general error
      print('Error fetching adult child care stations: $e');
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
          titleSearch: 'Search for adult childcare stations',
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
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
      displayedAdultChildCare = displayedAdultChildCare
          .where((adultChildCare) =>
              adultChildCare.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedAdultChildCare.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedAdultChildCare.map((adultChildCare) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: adultChildCare.name,
                    image: adultChildCare.image,
                    phoneNumber: adultChildCare.phone_number,
                    onPressed: () {
                      _handleServiceRequest(adultChildCare);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(AdultChildCare adultChildCare) {
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
          location: adultChildCare.location,
          name: adultChildCare.name,
          phoneNumber: adultChildCare.phone_number,
          onPressed: () {
            _showServiceRequestedDialog(adultChildCare);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(AdultChildCare adultChildCare) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content:
              Text('You have requested service from ${adultChildCare.name}.'),
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
