import 'dart:async';

import 'package:bellbirdmvp/bloc/bloc/chat_bloc.dart';
import 'package:bellbirdmvp/models/messages.dart';
import 'package:bellbirdmvp/util/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  Stream<List<Chat>> getChats() {
    return null;
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    print('njkjnhlkjlkjlkjlkjj????????????????????????????????????????');

    var chatDocRef = firestore.collection('/conversations').doc(chatId);
    var messagesCollection = chatDocRef
        .collection('conversations')
        .orderBy('timeStamp', descending: true);
    return messagesCollection.limit(20).snapshots();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String chatId, String message, String senderId,
      String receiverId, String sendersName) async {
    DocumentReference chatDocRef =
        firestore.collection('conversations').doc(chatId);
    CollectionReference messagesCollection =
        chatDocRef.collection('conversations');
    messagesCollection.add({
      'message': message,
      'timeStamp': Timestamp.now(),
      'senderId': senderId,
      'receiverId': receiverId,
      'sendersName': sendersName,
      'type': 'text'
    });

    firestore
        .collection('Users')
        .doc(receiverId)
        .collection('conversations')
        .doc(senderId)
        .update({
      'lastMessage': message,
      'unSeenCount': FieldValue.increment(1),
      'timeStamp': Timestamp.now(),
      'type': 'text'
    });
    firestore
        .collection('Users')
        .doc(senderId)
        .collection('conversations')
        .doc(receiverId)
        .update({
      'lastMessage': message,
      'timeStamp': Timestamp.now(),
      'type': 'text'
    });
  }

  Future<QuerySnapshot> getPreviousMessages(
      String chatId, DocumentSnapshot prevMessage) async {
    DocumentReference chatDocRef =
        firestore.collection('/conversations').doc(chatId);
    CollectionReference messagesCollection =
        chatDocRef.collection('conversations');
    // gets a reference to the last message in the existing list
    final querySnapshot = await messagesCollection
        // Start reading documents after the specified document
        .orderBy('timeStamp', descending: true)
        .startAfterDocument(prevMessage) // order them by timestamp
        .limit(20) // limit the read to 20 items
        .get();

    return querySnapshot;
  }

  void dispose() {}
}
