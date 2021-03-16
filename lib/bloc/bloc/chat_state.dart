part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  ChatState([List props = const <dynamic>[]]);
}

class InitialChatState extends ChatState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchedChatListState extends ChatState {
  final List<Chat> chatList;

  FetchedChatListState(this.chatList) : super([chatList]);

  @override
  String toString() => 'FetchedChatListState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchingMessageState extends ChatState {
  @override
  String toString() => 'FetchingMessageState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchedMessagesState extends ChatState {
  final QuerySnapshot messages;
  final isPrevious;
  FetchedMessagesState(this.messages, {this.isPrevious})
      : super([messages, isPrevious]);

  @override
  String toString() =>
      'FetchedMessagesState {messages: ${messages.documents.length}, username: , isPrevious: $isPrevious}';

  @override
  List<Object> get props => [messages, isPrevious];
}

class ErrorState extends ChatState {
  final Exception exception;

  ErrorState(this.exception) : super([exception]);

  @override
  String toString() => 'ErrorState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchedContactDetailsState extends ChatState {
  final user;
  final String username;
  FetchedContactDetailsState(this.user, this.username)
      : super([user, username]);

  @override
  String toString() => 'FetchedContactDetailsState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PageChangedState extends ChatState {
  final int index;
  final Chat activeChat;
  PageChangedState(this.index, this.activeChat) : super([index, activeChat]);

  @override
  String toString() => 'PageChangedState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ToggleEmojiKeyboardState extends ChatState {
  final bool showEmojiKeyboard;

  ToggleEmojiKeyboardState(this.showEmojiKeyboard) : super([showEmojiKeyboard]);

  @override
  String toString() => 'ToggleEmojiKeyboardState';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
