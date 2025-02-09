import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:http/http.dart' as http;

class MessagesViewModel extends ChangeNotifier {
  final List<Map<String, String>> messages = [

  ];

  final TextEditingController messageController = TextEditingController();
  final String apiUrl = "https://basevenue-wolf.vercel.app/api/chat"; // Replace with actual URL
 // final String apiKey = "YOUR_API_KEY"; // Set this in your environment (keep it secure)

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
    final accounts = await ethereum!.requestAccount(); // Request account access
    String? walletAddress = accounts.first;
    debugPrint("wallet adress ${walletAddress}");

    final userMessage = messageController.text.trim();
    if (userMessage.isEmpty) return;
    print("send message");
    addMessage("user", userMessage);

    final requestBody = jsonEncode({
      "messages": messages
          .map((msg) => {"role": msg["role"], "content": msg["text"]})
          .toList(),
      "userWalletAddress": "$walletAddress"
    });
    print("Error requestBody: $requestBody");
    try {
      final request = http.Request("POST", Uri.parse(apiUrl))
        ..headers.addAll({
          "Content-Type": "application/json",
        })
        ..body = requestBody;

      final response = await http.Client().send(request);
      print("response $response");
      if (response.statusCode == 200) {
        // Read the response stream into a buffer.
        final stream = response.stream.transform(utf8.decoder);
        StringBuffer buffer = StringBuffer();
        await for (String chunk in stream) {
          buffer.write(chunk);
          notifyListeners();
        }

        String rawResponse = buffer.toString().trim();

        // Remove any "data:" prefixes
        rawResponse = rawResponse.replaceAll(RegExp(r"data:\s*"), "").trim();

        // Option: Try to find the first complete JSON object by ensuring braces match.
        int openBraces = 0;
        int endIndex = -1;
        for (int i = 0; i < rawResponse.length; i++) {
          if (rawResponse[i] == '{') openBraces++;
          if (rawResponse[i] == '}') openBraces--;
          if (openBraces == 0 && rawResponse[i] == '}') {
            endIndex = i;
            break;
          }
        }

        if (endIndex != -1) {
          rawResponse = rawResponse.substring(0, endIndex + 1);
        }

        final responseData = jsonDecode(rawResponse);
        final String aiResponse = responseData["content"] ?? "No response received.";

        print("AI Response: $aiResponse");
        addMessage("ai", aiResponse);

      } else {
        addMessage("ai", "Error: Failed to connect to AI.");
      }
    } catch (e) {
      addMessage("ai", "Error: $e");
      print("Error: $e");
    }
  }




  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
