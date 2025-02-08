import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../color_palette.dart';
import '../../view_model/messages_view_model.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<MessagesViewModel>().messages;

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isUser = msg["role"] == "user";

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser ? ColorPalette.primaryVariant : ColorPalette.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SelectableText(
              msg["text"]!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
