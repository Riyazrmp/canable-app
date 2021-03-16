import 'dart:async';

import 'package:bellbirdmvp/repository/chatRepository.dart';
import 'package:bellbirdmvp/repository/userdataRepository.dart';
import 'package:bellbirdmvp/util/exception.dart';
import 'package:bellbirdmvp/util/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository = ChatRepository();
  Map<String, StreamSubscription> messagesSubscriptionMap = Map();
  StreamSubscription chatsSubscription;
  String activeChatId;

  ChatBloc() : super(null);

  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    print(event);

    if (event is FetchChatListEvent) {
      yield* mapFetchChatListEventToState(event);
    }
    if (event is RegisterActiveChatEvent) {
      activeChatId = event.activeChatId;
    }
    if (event is ReceivedChatsEvent) {
      yield FetchedChatListState(event.chatList);
    }
    if (event is PageChangedEvent) {
      activeChatId = event.activeChat.chatId;
      yield PageChangedState(event.index, event.activeChat);
    }
    if (event is FetchConversationDetailsEvent) {
      yield* mapFetchConversationDetailsEventToState(event);
    }
    if (event is FetchMessagesEvent) {
      yield* mapFetchMessagesEventToState(event);
    }
    if (event is FetchPreviousMessagesEvent) {
      yield* mapFetchPreviousMessagesEventToState(event);
    }
    if (event is ReceivedMessagesEvent) {
      print('dispatching received messages');
      print(event.messages.docs.first.data);
      yield FetchedMessagesState(event.messages, isPrevious: false);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      firestore
          .collection('Users')
          .doc(event.currentUserId)
          .collection('conversations')
          .doc(event.receiversId)
          .update({
        'unSeenCount': 0,
      });
    }
    if (event is SendTextMessageEvent) {
      await chatRepository.sendMessage(event.message, event.chatId,
          event.senderId, event.receiverId, event.receiversName);
    }

    if (event is ToggleEmojiKeyboardEvent) {
      yield ToggleEmojiKeyboardState(event.showEmojiKeyboard);
    }
  }

  Stream<ChatState> mapFetchChatListEventToState(
      FetchChatListEvent event) async* {
    try {
      chatsSubscription?.cancel();
      chatsSubscription = chatRepository
          .getChats()
          .listen((chats) => add(ReceivedChatsEvent(chats)));
    } on MessioException catch (exception) {
      print(exception.errorMessage());
      yield ErrorState(exception);
    }
  }

  Stream<ChatState> mapFetchMessagesEventToState(
      FetchMessagesEvent event) async* {
    try {
      yield FetchingMessageState();
      String chatId = event.chatId;
      print('mapFetchMessagesEventToState');
      print('MessSubMap: $messagesSubscriptionMap');

      StreamSubscription messagesSubscription = messagesSubscriptionMap[chatId];
      messagesSubscription?.cancel();
      messagesSubscription = chatRepository.getMessages(chatId).listen(
          (messages) => add(ReceivedMessagesEvent(
              messages, event.chatId, event.currentUserId, event.receiversId)));

      messagesSubscriptionMap[chatId] = messagesSubscription;
    } on MessioException catch (exception) {
      print(exception.errorMessage());
      print('errrrrrrrrRrrrrrrr!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      yield ErrorState(exception);
    }
  }

  Stream<ChatState> mapFetchPreviousMessagesEventToState(
      FetchPreviousMessagesEvent event) async* {
    try {
      String chatId = event.chatId;
      final messages =
          await chatRepository.getPreviousMessages(chatId, event.lastMessage);
      yield FetchedMessagesState(messages, isPrevious: true);
    } on MessioException catch (exception) {
      print(exception.errorMessage());
      yield ErrorState(exception);
    }
  }

  Stream<ChatState> mapFetchConversationDetailsEventToState(
      FetchConversationDetailsEvent event) async* {
    print('fetching details fro ${event.chatId}');
    add(FetchMessagesEvent(
        event.chatId, event.currentUserId, event.receiversId));
  }
}
