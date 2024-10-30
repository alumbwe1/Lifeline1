import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor:  Color(0xFFE3E5E7),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 70,
                  left: 5,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                    ),
                    Column(
                      children: [
                        Text('Alumbwe Munali',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black,),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            'Chats',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Text('34'),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 190,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFF27c1a9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFEFFFFC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                children: [
                  buildCoversationRow(
                      'Alumbwe', 'Hello how are you', 'final.png', 0),
                  buildCoversationRow(
                      'Robson', 'Hello how is Life?', 'back.jpg', 3),
                  buildCoversationRow(
                      'Jackson', ' hii there.', 'profile.jpeg', 5),
                  buildCoversationRow(
                      'Sarah', 'Boi how are you home', 'chat.png', 2),
                  buildCoversationRow(
                      'Loveness', 'Alumbwe how are you', 'back.jpg', 10),
                  buildCoversationRow(
                      'Farajah', 'Are you enjoying society?', 'home.png', 9),
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }

  Column buildCoversationRow(
      String name, String message, String filename, int msgCount) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                UserAvatar(filename: filename),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 5),
              child: Column(
                children: [
                  const Text(
                    '16:35',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (msgCount > 0)
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: const Color(0xFF27C1a9),
                      child: Text(
                        msgCount.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          indent: 70,
        ),
      ],
    );
  }

  Padding buildContactAvatar(final String name, final String filename) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: UserAvatar(
                filename: filename,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}


class UserAvatar extends StatelessWidget {
  final String filename;

  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 29,
        backgroundImage: AssetImage('assets/$filename'),
      ),
    );
  }
}
