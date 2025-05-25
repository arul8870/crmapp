part of 'chat_bloc.dart';

abstract class ChatPageEvent extends Equatable {
  const ChatPageEvent();

  @override
  List<Object?> get props => [];
}

class InitializeChat extends ChatPageEvent {
  final CustomerModel customer;
  final List<ChatMessage> initialMessages;

  const InitializeChat({
    required this.customer,
    this.initialMessages = const [],
  });

  @override
  List<Object?> get props => [customer, initialMessages];
}

class SendChatMessage extends ChatPageEvent {
  final ChatMessage message;
  final bool simulateResponse;

  const SendChatMessage({required this.message, this.simulateResponse = false});

  @override
  List<Object?> get props => [message, simulateResponse];
}

class ReceiveChatMessage extends ChatPageEvent {
  final ChatMessage message;

  const ReceiveChatMessage({required this.message});

  @override
  List<Object?> get props => [message];
}
