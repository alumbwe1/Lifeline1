import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.blue,

                          )

                        ),
                        hintText: 'Search stations',
                        border: OutlineInputBorder(

                        ),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Use Map',
                    style: TextStyle(
                      // Add your text style properties here
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Add more widgets or components here as needed
          ],
        ),
      ),
    );
  }
}
