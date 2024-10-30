import 'package:flutter/material.dart';
import 'package:lifeline/features/screens/contact-list.dart';
class ChooseContactCategory extends StatelessWidget {
  const ChooseContactCategory({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Choose Category',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            // List of Counselor Cards
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
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
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactList(),),);
        },
        child: Container(
          width: cardWidth,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  counselor.avatar,
                  fit: BoxFit.cover,
                ),
              ),
              // Text at the Bottom
              Padding(
                padding: const EdgeInsets.only(top: 50,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        counselor.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                        ),
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
  Counselor(name: 'police', expertise: '20k Contacts', avatar: 'assets/nice.jpg'),
  Counselor(name: 'Ambulance', expertise: '200 Contacts', avatar: 'assets/music.jpg'),
  Counselor(name: 'Firebrigade', expertise: '300 Contacts', avatar: 'assets/adult.jpg'),
  Counselor(name: 'More Services', expertise: '400 Contacts', avatar: 'assets/nice.jpg'),
  Counselor(name: 'AdultChildCare', expertise: '500 Contacts', avatar: 'assets/nice.jpg'),
  // Add more counselor data as needed
];



