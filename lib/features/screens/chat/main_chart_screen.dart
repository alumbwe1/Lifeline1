import 'package:flutter/material.dart';
import 'package:lifeline/features/screens/chat/chat_screen.dart';

class ChooseCounselorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Counsellors',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text indicating the number of counselors found
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${counselors.length} Counsellors found',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatListPage(),),);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(child: Text('Chat')),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // List of Counselor Cards
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: counselors.length,
                itemBuilder: (context, index) {
                  return CounselorCard(
                    counselor: counselors[index],
                    index: index,
                    cardWidth: cardWidth,
                  );
                },
              ),
            ),
            // Add to Chat Button
          ],
        ),
      ),
    );
  }
}

class CounselorCard extends StatelessWidget {
  final Counselor counselor;
  final int index;
  final double cardWidth;

  const CounselorCard({
    Key? key,
    required this.counselor,
    required this.index,
    required this.cardWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: cardWidth,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                counselor.avatar,
                fit: BoxFit.cover,
              ),
            ),
            // Text at the Bottom
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    counselor.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    counselor.expertise,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Counselor {
  final String name;
  final String expertise;
  final String avatar;

  Counselor({
    required this.name,
    required this.expertise,
    required this.avatar,
  });
}

List<Counselor> counselors = [
  Counselor(name: 'Alumbwe', expertise: 'Self Management', avatar: 'assets/nice.jpg'),
  Counselor(name: 'Lushomo', expertise: 'Music Counseling', avatar: 'assets/music.jpg'),
  Counselor(name: 'Milimo', expertise: 'Stress Management', avatar: 'assets/adult.jpg'),
  Counselor(name: 'Malambo', expertise: 'Stigma Counseling', avatar: 'assets/doctor.jpg'),
  // Add more counselor data as needed
];
