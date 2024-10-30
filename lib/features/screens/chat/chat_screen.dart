
import 'package:flutter/material.dart';
import 'package:lifeline/features/screens/chat/chat_details.dart';

import 'package:lifeline/features/screens/chat/main_chart_screen.dart';
class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;

  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}

class ChatListPage extends StatelessWidget {
  final List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup,how are you doing in Lusaka there?", imageURL: "assets/nice.jpg", time: "Now"),
    ChatUsers(name: "Glad's Murphy", messageText: "That's Great how are you doing there.", imageURL: "assets/doctor.jpg", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "assets/music.jpg", time: "31/01/23"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "assets/adult.jpg", time: "28/03/22"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thank you, It's awesome", imageURL: "assets/nice.jpg", time: "23/12/21"),
    ChatUsers(name: "Jacob Pena", messageText: "Will update you in the evening", imageURL: "assets/back.jpg", time: "6 min ago"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "assets/back.jpg", time: "4 min ago"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "assets/doctor.jpg", time: "2 min ago"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Chats',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(

            radius: 35,
              child: Image.asset('assets/s.png',height: 28,width: 28,),
          ),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseCounselorPage(),),);
                },
                  child: Image.asset('assets/add-user.png',height: 28,width: 28,)),

            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 16, top: 10),
              child:   Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child:  const Center(child: Text('Messages')),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[

                  const SizedBox(width: 8),
                  ...chatUsers.map((user) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        CircleAvatar(
                          radius: 37,
                          backgroundColor: Colors.lightGreen,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(user.imageURL),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          truncateText(user.name, maxWords: 1),
                          semanticsLabel: user.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(

                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: ListView.builder(
                itemCount: chatUsers.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationList extends StatefulWidget {
  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final bool isMessageRead;

  const ConversationList({super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
  });

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatDetailPage(),
          ),
        );
        // Add action when a conversation is tapped
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 37,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.imageUrl),
                        maxRadius: 30,

                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(widget.name, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                              const Spacer(),
                              Text(
                                widget.time,
                                style: const TextStyle(color: Colors.grey,),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.messageText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              const CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.lightGreen,
                                child: Text('3',style: TextStyle(color: Colors.white,),),
                              ),
                            ],
                          ),
                        ],
                      ),
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

String truncateText(String text, {int maxWords = 1}) {
  List<String> words = text.split(' ');
  if (words.length > maxWords) {
    return '${words.take(maxWords).join(' ')}...';
  } else {
    return text;
  }
}
