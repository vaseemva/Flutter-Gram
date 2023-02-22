import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/chat_screen/chat_detail_screen.dart';
import 'package:flutter_gram/utils/global.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: ChatMethods().getMessages(currentUserUid!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
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
                                username: assnapshot.data!['username']),
                          ));
                        },
                        child: ListTile(
                          title: Text(assnapshot.data!['username']),
                        ),
                      );
                    });
              },
            );
          }),
    );
  }
}
