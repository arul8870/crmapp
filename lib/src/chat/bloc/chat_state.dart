part of 'chat_bloc.dart';

enum ChatPageStatus { initial, loading, loaded, sending, success, failure }

class ChatPageState extends Equatable {
  final ChatPageStatus status;
  final String? message;
  final List<ChatMessage> messages;
  final CustomerModel? customer;

  const ChatPageState({
    this.status = ChatPageStatus.initial,
    this.message,
    this.messages = const [],
    this.customer,
  });

  static const initial = ChatPageState(
    status: ChatPageStatus.initial,
    messages: [],
    customer: null,
  );

  ChatPageState copyWith({
    ChatPageStatus Function()? status,
    String Function()? message,
    List<ChatMessage> Function()? messages,
    CustomerModel Function()? customer,
  }) {
    return ChatPageState(
      status: status != null ? status() : this.status,
      message: message != null ? message() : this.message,
      messages: messages != null ? messages() : this.messages,
      customer: customer != null ? customer() : this.customer,
    );
  }

  @override
  List<Object?> get props => [status, message, messages, customer];
}
