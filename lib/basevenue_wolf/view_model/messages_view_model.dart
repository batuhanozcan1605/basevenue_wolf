import 'package:flutter/material.dart';

class MessagesViewModel extends ChangeNotifier {
  final List<Map<String, String>> messages = [
    {"role": "ai", "text": "Hello! How can I assist you today?"},
    {"role": "user", "text": "How does token management work?"},
    {"role": "ai", "text": "Token management lets you mint, burn, and track your project's token usage."},
  ];

  void addMessage(String role, String text) {
    messages.add({"role": role, "text": text});
    notifyListeners();
  }


}
