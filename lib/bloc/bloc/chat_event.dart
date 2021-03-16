part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchChatListEvent extends ChatEvent {
  @override
  String toString() => 'FetchChatListEvent';
}

class Chat{
  String username;
  String chatId;
  Chat(this.username,this.chatId);
    List<Object> get props => [username,chatId];

  @override
  String toString() => '{ username= $username, chatId = $chatId}';
}
//triggered when stream containing list of chats has new data
class ReceivedChatsEvent extends ChatEvent {
  final List<Chat> chatList;

  ReceivedChatsEvent(this.chatList);
    List<Object> get props => [chatList];


  @override
  String toString() => 'ReceivedChatsEvent';
}

//triggered to get details of currently open conversation
class FetchConversationDetailsEvent extends ChatEvent {
  final  chatId;
  final currentUserId;
  final receiversId;

  FetchConversationDetailsEvent(this.chatId,this.currentUserId,this.receiversId);
    List<Object> get props => [chatId,currentUserId,receiversId];

  @override
  String toString() => 'FetchConversationDetailsEvent';
}

//triggered to fetch messages of chat, this will also keep a subscription for new messages
class FetchMessagesEvent extends ChatEvent {
  final  chatId;
  final currentUserId;
  final receiversId;
  FetchMessagesEvent(this.chatId,this.currentUserId,this.receiversId);
    List<Object> get props => [chatId,currentUserId,receiversId];

  @override
  String toString() => 'FetchMessagesEvent';
}
//triggered to fetch messages of chat
class FetchPreviousMessagesEvent extends ChatEvent {
  final String chatId;
  final DocumentSnapshot lastMessage;
  FetchPreviousMessagesEvent(this.chatId,this.lastMessage);
    List<Object> get props => [chatId,lastMessage];

  @override
  String toString() => 'FetchPreviousMessagesEvent';
}

//triggered when messages stream has new data
class ReceivedMessagesEvent extends ChatEvent {
  final QuerySnapshot messages;
  final String username;
  final currentUserId;
  final receiversId;

  ReceivedMessagesEvent(this.messages, this.username,this.currentUserId,this.receiversId);
    List<Object> get props => [messages,username,currentUserId,receiversId];

  @override
  String toString() => 'ReceivedMessagesEvent';
}

//triggered to send new text message
class SendTextMessageEvent extends ChatEvent {
  final String message;
 final String chatId;
 final String senderId;
 final String receiverId;
 final String receiversName;
 
  SendTextMessageEvent(this.message,this.chatId,this.senderId,this.receiverId,this.receiversName);
      List<Object> get props => [message,chatId,senderId,this.receiverId,this.receiversName];


  @override
  String toString() => 'SendTextMessageEvent {message: $message}';
}

//triggered to send attachment


//triggered on page change
class PageChangedEvent extends ChatEvent {
  final int index;
  final Chat activeChat;
  PageChangedEvent(this.index, this.activeChat);
    List<Object> get props => [index, activeChat];

  @override
  String toString() => 'PageChangedEvent {index: $index, activeChat: $activeChat}';
}

class RegisterActiveChatEvent extends ChatEvent{
  final String activeChatId;
  RegisterActiveChatEvent(this.activeChatId);
  @override
  String toString() => 'RegisterActiveChatEvent { activeChatId : $activeChatId }';
}

// hide/show emojikeyboard
class ToggleEmojiKeyboardEvent extends ChatEvent{
  final bool showEmojiKeyboard;

  ToggleEmojiKeyboardEvent(this.showEmojiKeyboard);

  @override
  String toString() => 'ToggleEmojiKeyboardEvent';
}