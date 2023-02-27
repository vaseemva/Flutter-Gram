import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/chat_screen/chat_detail_screen.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:get_time_ago/get_time_ago.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: ChatMethods().getMessagedUsers(currentUserUid!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Messages'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: FirestoreMethods()
                        .getUserDataF(snapshot.data![index]['user']),
                    builder: (context, assnapshot) {
                      if (!assnapshot.hasData) {
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(
                                chatWith: snapshot.data![index]['user'],
                                username: assnapshot.data!['username'],
                                profileImage:assnapshot.data!['profileImage'] ,),
                                
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(assnapshot.data!['profileImage']),
                          ),
                          title: Text(assnapshot.data!['username']),
                          subtitle: Text(
                              '${GetTimeAgo.parse(snapshot.data![index]['time'].toDate())} $lastMessageText'),
                        ),
                      );
                    });
              },
            );
          }),
    );
  }
}
