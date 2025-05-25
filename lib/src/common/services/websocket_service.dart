import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static const String socketUrl = 'wss://echo.websocket.org';

  late WebSocketChannel _channel;
  late StreamController<String> _messageController;
  Stream<String> get messageStream => _messageController.stream;

  WebSocketService() {
    _messageController = StreamController<String>.broadcast();
  }

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(socketUrl));

    _channel.stream.listen(
      (message) {
        _messageController.add(message);
      },
      onError: (error) {
        _messageController.addError(error);
      },
      onDone: () {
        _messageController.close();
      },
    );
  }

  void sendMessage(String message) {
    if (_channel != null) {
      _channel.sink.add(message);
    }
  }

  void disconnect() {
    _channel.sink.close();
    _messageController.close();
  }
}
