import 'dart:async';

import 'package:bellbirdmvp/Providers/baseProvider.dart';
import 'package:bellbirdmvp/Providers/chatprovider.dart';
import 'package:bellbirdmvp/bloc/bloc/chat_bloc.dart';
import 'package:bellbirdmvp/models/messages.dart';
import 'package:bellbirdmvp/repository/baseRepository.dart';
import 'package:bellbirdmvp/util/conversations.dart';
import 'package:bellbirdmvp/util/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatRepository extends BaseRepository{
  ChatProvider chatProvider = ChatProvider() ;
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<QuerySnapshot>getMessages(String chatId) => ChatProvider().getMessages(chatId);
  Future<QuerySnapshot> getPreviousMessages(
          String chatId, DocumentSnapshot prevMessage) =>
      ChatProvider().getPreviousMessages(chatId, prevMessage);


  Future<void> sendMessage( String message,String chatId,String senderId,String receiverId,String receiversName)=>chatProvider.sendMessage(chatId, message,senderId,receiverId,receiversName);

  

  @override
  void dispose() {
    chatProvider.dispose();
  }
}