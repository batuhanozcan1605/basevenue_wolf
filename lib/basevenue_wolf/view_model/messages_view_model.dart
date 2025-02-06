import 'package:flutter/material.dart';

class MessagesViewModel extends ChangeNotifier {
  final List<Map<String, String>> messages = [
    {"role": "ai", "text": "Hello! How can I assist you today?"},
    {"role": "user", "text": "How does token management work?"},
    {"role": "ai", "text": "Token management lets you mint, burn, and track your project's token usage."},
  ];

  final TextEditingController messageController = TextEditingController();

  MessagesViewModel() {
    messageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    notifyListeners(); // Notify UI when text changes
  }

  void addMessage(String role, String text) {
    messages.add({"role": role, "text": text});
    messageController.clear();
    notifyListeners();
  }

  void setMessageText(String newText) {
    messageController.text = newText;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: newText.length), // Moves cursor to end of text
    );
    notifyListeners();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
