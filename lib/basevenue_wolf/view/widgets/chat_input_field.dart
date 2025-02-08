import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../color_palette.dart';
import '../../view_model/messages_view_model.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  void _sendMessage(BuildContext context) {
    final messagesViewModel = context.read<MessagesViewModel>();
    messagesViewModel.sendMessage(); // Now using the streaming function
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessagesViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Aligns input field properly
        children: [
          // Input Field (Auto-Expands)
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 150, // Prevents excessive expansion
              ),
              child: TextField(
                controller: viewModel.messageController,
                minLines: 1, // Starts with a single line
                maxLines: null, // Expands dynamically
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Ask AI something...",
                  hintStyle: TextStyle(color: ColorPalette.light),
                  filled: true,
                  fillColor: ColorPalette.secondaryVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Send Button
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () => _sendMessage(context),
          ),
        ],
      ),
    );
  }
}
