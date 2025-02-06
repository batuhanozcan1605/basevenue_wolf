import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/messages_view_model.dart';

class ChatInputField extends StatefulWidget {
  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      final messageText = _controller.text.trim();
      _controller.clear();

      // Add user message
      context.read<MessagesViewModel>().addMessage("user", messageText);

      // Simulate AI Response
      Future.delayed(const Duration(seconds: 1), () {
        context.read<MessagesViewModel>().addMessage("ai", "Great question! Let me analyze it...");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Input Field
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Ask AI something...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Send Button
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
