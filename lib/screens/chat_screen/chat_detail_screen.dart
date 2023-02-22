import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:flutter_gram/utils/global.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({Key? key, required this.chatWith, required this.username})
      : super(key: key);
  final String chatWith;
  final String username;
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: ChatMethods().getMessagesInChat(currentUserUid!, chatWith),
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
                bool isMe = snapshot.data![index]['sender'] == currentUserUid;
                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[200] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(snapshot.data![index]['message']),
                    ),
                  ],
                );
              },
            );
          }),
      bottomNavigationBar: SafeArea(
          child: Container(
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 16,
                  //   backgroundImage: NetworkImage(user.profileImage),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child:
                          //  Consumer<FieldProvider>(
                          //   builder: (context, value, child) =>
                          TextField(
                        controller: _chatController,
                        decoration: const InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 16,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                    await  ChatMethods().sendMessage(
                          currentUserUid!, chatWith, _chatController.text);
                          _chatController.clear();
                    },
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ))),
    );
  }
}
