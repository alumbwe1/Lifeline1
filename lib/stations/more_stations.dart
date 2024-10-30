import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classes/more.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';
import '../core/urls.dart';
import '../database helpers/more_model.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<More> displayedMore = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMoreServices(); // Fetch more services when the page is initialized
  }

  // Function to fetch more services from the Django server
  Future<void> _fetchMoreServices() async {
    try {
      // Step 1: Try to fetch cached data
      List<More> cachedMoreServices = await MoreDataHelper.getCachedData();

      if (cachedMoreServices.isNotEmpty) {
        setState(() {
          displayedMore = cachedMoreServices;
        });
      }

      // Step 2: Fetch data from the server
      final response = await http.get(Uri.parse(more));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Step 3: Update state with data from the server
        setState(() {
          displayedMore = data.map((json) => More.fromJson(json)).toList();
        });

        // Step 4: Cache the data for offline usage
        await MoreDataHelper.cacheData(displayedMore);
      } else {
        // Handle error when fetching from the server
        print('Failed to load more services: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general error
      print('Error fetching more services: $e');
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
            child: _buildServiceList(),
          ),
        ],
      ),
    );
  }

  void _search(String query) {
    setState(() {
      displayedMore = displayedMore
          .where(
              (more) => more.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildServiceList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedMore.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedMore.map((more) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: more.name,
                    image: more.image,
                    phoneNumber: more.phone_number,
                    onPressed: () {
                      _handleServiceRequest(more);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(More more) {
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
          name: more.name,
          location: more.location,
          phoneNumber: more.phone_number,
          onPressed: () {
            _showServiceRequestedDialog(more);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(More more) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${more.name}.'),
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
