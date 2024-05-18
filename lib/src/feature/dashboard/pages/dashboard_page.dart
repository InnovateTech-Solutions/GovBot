import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late IO.Socket _socket;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();

    _socket.onConnect((_) {
      print('Connected');
    });

    _socket.on('response', (data) {
      setState(() {
        _isTyping = false;
        _messages
            .add(ChatMessage(text: data['response'], isUserMessage: false));
      });
    });

    _socket.onDisconnect((_) {
      print('Disconnected');
    });
  }

  @override
  void dispose() {
    _socket.disconnect();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(ChatMessage(text: message, isUserMessage: true));
      _isTyping = true; // Set typing to true when sending message
    });

    _controller.clear();
    _socket.emit('query', {'user_input': message});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return ListTile(
                  title: Align(
                    alignment: message.isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.isUserMessage
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(message.text),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _isTyping
                          ? 'Bot is typing...'.tr
                          : 'Type your message'.tr,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.lightAppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.lightAppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.lightAppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (text) => _sendMessage(text),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppTheme.lightAppColors.primary,
                  ),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}
