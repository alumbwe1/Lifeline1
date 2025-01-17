import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/stations/adult_child_care.dart';
import 'package:lifeline/stations/ambulance_stations.dart';
import 'package:lifeline/stations/firebrigade_station.dart';
import 'package:lifeline/stations/more_stations.dart';
import 'package:lifeline/stations/police_stations.dart';

class ServicesList extends StatelessWidget {
  final List<ServiceItem> services;

  const ServicesList({
    Key? key,
    required this.services,
    required Null Function(ServiceItem selectedService) onServiceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:  const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Please, choose your \nemergency service?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children:
              services.map((service) => ListOfService(service)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem {
  final String image;
  final String name;

  ServiceItem({required this.image, required this.name});
}

class ListOfService extends StatelessWidget {
  final ServiceItem service;

  const ListOfService(this.service, {Key? key});

  void navigateToSpecificPage(BuildContext context) {
    // Implement logic here to determine which page to navigate to based on the selected service
    switch (service.name) {
      case 'Police':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationsPage(),
          ),
        );
        break;
      case 'FireBrigade':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FireBrigadePage(),
          ),
        );
        break;
      case 'AdultChildCare':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdultChildCarePage(),
          ),
        );
        break;
      case 'Ambulance':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AmbulancePage(),
          ),
        );
        break;
      case 'More Services':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MorePage(),
          ),
        );
        break;
    // Add more cases as needed for other services
      default:
      // Handle the default case or do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToSpecificPage(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
           // Set your desired background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
             width: 90,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(service.image,height: 30,width: 50,color: Colors.white,),
            ),
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 20,
                // Set your desired text color
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
