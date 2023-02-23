import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(
      String currentUser, String receiver, String message) async {
    try {
      await addOrUpdateCurrentUser(currentUser, receiver);
      await _firestore.collection('chats').doc(currentUser).set({
        "lastMessage": message,
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
      await addOrUpdateCurrentUser(receiver, currentUser);
      await _firestore.collection('chats').doc(receiver).set({
        "lastMessage": message,
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
        .collection('users')
        .doc(currentUser)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        List<Map<String, dynamic>> messages =
            List.from((documentSnapshot.data() as dynamic)['chattedUsers']);
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
        .orderBy(
          'time',
        )
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> messages = [];
      querySnapshot.docs.forEach((doc) {
        messages.add(doc.data() as Map<String, dynamic>);
      });
      return messages;
    });
  }

  addOrUpdateCurrentUser(String uid, String recieverUid) async {
    // Get a reference to the user's document
    DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(uid); // replace `userId` with the ID of the user's document

    // Get the current data of the user's document
    DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();

    // Check if the chattedUsers array field already contains a map with the specified username
    List<dynamic> chattedUsers = snapshot.data()!['chattedUsers'];
    int index = chattedUsers.indexWhere((user) => user['user'] == recieverUid);

    if (index != -1) {
      // If the chattedUsers array field contains a map with the specified username, update the time value of the existing map
      Map<String, dynamic> userData = {
        'user': recieverUid,
        'time': Timestamp.now()
      };
      chattedUsers[index] = userData;
      await docRef.update({'chattedUsers': chattedUsers});
    } else {
      // If the chattedUsers array field does not contain a map with the specified username, create a new map with the specified username and current time, and add it to the chattedUsers array field
      Map<String, dynamic> userData = {
        'user': recieverUid,
        'time': Timestamp.now()
      };
      await docRef.update({
        'chattedUsers': FieldValue.arrayUnion([userData])
      });
    }
  }
}
