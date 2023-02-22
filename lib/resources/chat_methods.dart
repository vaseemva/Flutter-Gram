import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(
      String currentUser, String receiver, String message) async {
    try {
      // await _firestore.collection('chats').doc(currentUser).update({
      //   'lastMessage': message,
      //   'lastMessageTime': DateTime.now(),
      //   'lastMessageSender': currentUser,
      //   'lastMessageReceiver': receiver,
      //   //add an array of map which include users who have sent messages to the current user with time of last message
      //   'users': FieldValue.arrayUnion([
      //     {
      //       'user': receiver,
      //       'time': DateTime.now(),
      //     }
      //   ]), 
      // },);
      await updateUsersArray(currentUser, receiver); 
      await _firestore.collection('chats').doc(receiver).set({
        'lastMessage': message,
        'lastMessageTime': DateTime.now(),
        'lastMessageSender': currentUser,
        'lastMessageReceiver': receiver,
        'users': FieldValue.arrayUnion([
          {
            'user': currentUser,
            'time': DateTime.now(),
          }
        ]),
      });

      String messageId = const Uuid().v1();
      await _firestore
          .collection('chats')
          .doc(currentUser)
          .collection(receiver)
          .doc(messageId)
          .set({
        'message': message,
        'sender': currentUser,
        'receiver': receiver,
        'time': DateTime.now(),
        'messageId': messageId,
      });

      await _firestore
          .collection('chats')
          .doc(receiver)
          .collection(currentUser)
          .doc(messageId)
          .set({
        'message': message,
        'sender': currentUser,
        'receiver': receiver,
        'time': DateTime.now(),
        'messageId': messageId,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //stream of names of subcollections in the current user doc in chats collection
 Stream<List<Map<String, dynamic>>> getMessagedUsers(String currentUser) {
    return _firestore
        .collection('chats')
        .doc(currentUser)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        List<Map<String, dynamic>> messages =
            List.from((documentSnapshot.data() as dynamic)['users']);
        messages.sort((a, b) => b['time'].compareTo(a['time']));
        return messages;
      } else {
        return [];
      }
    });
  }

  //stream of messages in the subcollection of the current user doc in chats collection
  Stream<List<Map<String, dynamic>>> getMessagesInChat(
      String currentUser, String receiver) {
    return _firestore
        .collection('chats')
        .doc(currentUser)
        .collection(receiver)
        .orderBy('time',)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> messages = [];
      querySnapshot.docs.forEach((doc) {
        messages.add(doc.data() as Map<String, dynamic>);
      });
      return messages;
    });
  }

  Future<void> updateUsersArray(String currentUser, String receiver) async {
  final docRef = _firestore.collection('chats').doc(currentUser);
  final docSnapshot = await docRef.get();
  final usersArray = docSnapshot.data()?['users'] as List<dynamic>?;
  final currentTime = DateTime.now();

  // Check if the receiver already exists in the users array
  final receiverExists =
      usersArray?.any((user) => user['user'] == receiver) ?? false;

  if (receiverExists) {
    // If the receiver exists, update the timestamp of the existing user
    final updatedUsersArray = usersArray!
        .map((user) => user['user'] == receiver
            ? {'user': receiver, 'time': currentTime}
            : user)
        .toList();
    await docRef.update({'users': updatedUsersArray});
  } else {
    // If the receiver does not exist, add a new user to the array
    await docRef.set({
      'lastMessage': '',
      'lastMessageTime': Timestamp.now(),
      'lastMessageSender': '',
      'lastMessageReceiver': '',
      'users': FieldValue.arrayUnion([
        {'user': receiver, 'time': currentTime}
      ])
    }, SetOptions(merge: true));
  }
}

}
