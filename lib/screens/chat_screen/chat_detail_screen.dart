import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:flutter_gram/screens/chat_screen/widgets/chat_bubble.dart';
import 'package:flutter_gram/utils/global.dart';


class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({Key? key, required this.chatWith, required this.username})
      : super(key: key);
  final String chatWith;
  final String username;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
            WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
            return ListView.builder(
              
              controller: _scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                bool isMe = snapshot.data![index]['sender'] == currentUserUid;
                return ChatBubble(
                  isMe: isMe,
                  message: snapshot.data![index],
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
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
                      if (_chatController.text.isNotEmpty) {
                        await ChatMethods().sendMessage(
                            currentUserUid!, chatWith, _chatController.text); 
                        _chatController.clear();
                      }
                    },
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ))),
    );
  }
}

