import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:get_time_ago/get_time_ago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isMe,
    required this.message,
  });

  final bool isMe;
  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        isMe ? showDelete(context) : null;
      },
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Colors.blue[200],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft:
                    isMe ? const Radius.circular(12) : const Radius.circular(0),
                bottomRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(12),
              ),
            ),
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message['message']),
                Text(
                  GetTimeAgo.parse(message['time'].toDate()),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDelete(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 130, 
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete for everyone'),
                onTap: () async {
                  await ChatMethods().deleteMessage(message['sender'],
                      message['receiver'], message['messageId']);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete for me'),
                onTap: () async {
                  await ChatMethods().deleteMessageForCurrentUser(
                      message['sender'],
                      message['receiver'],
                      message['messageId']);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
