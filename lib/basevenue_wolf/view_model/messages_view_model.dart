import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagesViewModel extends ChangeNotifier {
  final List<Map<String, String>> messages = [
    {"role": "ai", "text": "Hello! How can I assist you today?"},
  ];

  final TextEditingController messageController = TextEditingController();
  final String apiUrl = "https://your-api-endpoint.com/api/chat"; // Replace with actual URL
  final String apiKey = "YOUR_API_KEY"; // Set this in your environment (keep it secure)


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

  Future<void> sendMessage() async {
    final userMessage = messageController.text.trim();
    if (userMessage.isEmpty) return;

    addMessage("user", userMessage);

    final requestBody = jsonEncode({
      "messages": messages.map((msg) => {"role": msg["role"], "content": msg["text"]}).toList(),
    });

    try {
      final request = http.Request("POST", Uri.parse(apiUrl))
        ..headers.addAll({
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        })
        ..body = requestBody;

      final response = await http.Client().send(request);

      if (response.statusCode == 200) {
        final stream = response.stream.transform(utf8.decoder);

        StringBuffer buffer = StringBuffer();
        await for (String chunk in stream) {
          buffer.write(chunk);
          notifyListeners();
        }

        addMessage("ai", buffer.toString().trim());
      } else {
        addMessage("ai", "Error: Failed to connect to AI.");
      }
    } catch (e) {
      addMessage("ai", "Error: $e");
    }
  }


  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
