import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../classes/alerts.dart';

class AlertsDetails extends StatefulWidget {
  final Alerts alert;

  const AlertsDetails({
    Key? key,
    required this.alert,
  }) : super(key: key);

  @override
  State<AlertsDetails> createState() => _AlertsDetailsState();
}

class _AlertsDetailsState extends State<AlertsDetails> {
  late Alerts _alert;

  @override
  void initState() {
    super.initState();
    _alert = widget.alert;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Details(
          image: _alert.body_image,
          title: _alert.short_description,
          user: _alert.username,
          details: _alert.details,
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final String image;
  final String details;
  final String title;
  final String user;

  const Details({
    Key? key,
    required this.details,
    required this.image,
    required this.title,
    required this.user,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                widget.user,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _getCurrentDate(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.details,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

String _getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('MMMM d, y').format(now);
}
