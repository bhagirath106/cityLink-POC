import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService(String url)
    : channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<Map<String, dynamic>> get stream =>
      channel.stream.map((event) => json.decode(event));

  void dispose() {
    channel.sink.close();
  }
}
