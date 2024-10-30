import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/components/button_report.dart';
import 'package:lifeline/features/screens/addscreens/add_contacts_lists_screen.dart';
import 'package:lifeline/features/screens/chat/chat_screen.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  TextEditingController searchController = TextEditingController();

  List<Contact> contacts = [
    Contact(name: 'Alumbwe Munali Mweetwa', phoneNumber: '097590503', image: 'assets/music.jpg'),
    Contact(name: 'Alumbwe Munali', phoneNumber: '097590503', image: 'assets/doctor.jpg'),
    Contact(name: 'Alumbwe Peter', phoneNumber: '097590503', image: 'assets/nice.jpg'),
    Contact(name: 'Mulekwa Nalube', phoneNumber: '097590503', image: 'assets/music.jpg'),
    Contact(name: 'Alumbwe X', phoneNumber: '097590503', image: 'assets/nice.jpg'),
    // Add more contacts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 35,
            child: Image.asset('assets/s.png', height: 28, width: 28),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddToContactLists()));
                },
                child: Image.asset('assets/add-user.png', height: 28, width: 28),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ContactItem(contact: contacts[index]);
          },
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String phoneNumber;
  final String image;

  Contact({required this.name, required this.phoneNumber, required this.image});
}

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.lightGreen,
            child: CircleAvatar(
              radius: 31,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 27,
                backgroundImage: AssetImage(contact.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  truncateText(contact.name,maxWords: 1,),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  contact.phoneNumber,
                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AvatarGlow(
              glowShape: BoxShape.circle,
              repeat: true,
              glowColor: Colors.blue,
              child: Image.asset('assets/telephone.png', height: 25, width: 25),
            ),
          )
        ],
      ),
    );

  }
}


String truncateText(String text, {int maxWords = 1}) {
  List<String> words = text.split(' ');
  if (words.length > maxWords) {
    return '${words.take(maxWords).join(' ')}...';
  } else {
    return text;
  }
}
