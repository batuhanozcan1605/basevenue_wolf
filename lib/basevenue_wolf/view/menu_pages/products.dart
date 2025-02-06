import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/propmts.dart';
import '../../view_model/messages_view_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool isCreatingToken = false; // To track which form to show
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController functionalityController = TextEditingController();
  final TextEditingController priceRatioController = TextEditingController();

  void handleCreateToken() {
    setState(() {
      isCreatingToken = true;
    });
  }

  void handleCreateNFT() {
    setState(() {
      isCreatingToken = false;
    });
  }

  void handleSubmit(BuildContext context) {
    final messagesViewModel = Provider.of<MessagesViewModel>(context, listen: false);
    // Extract user input
    String projectName = "Project Name"; // Use dynamic project name
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    String functionality = functionalityController.text.trim();
    String priceRatio = priceRatioController.text.trim().isEmpty ? "1:1" : priceRatioController.text.trim();

    // Validate name before generating symbol
    String tokenSymbol = name.isNotEmpty ? name.toUpperCase().substring(0, min(3, name.length)) : "TKN";

    // Generate AI prompt
    String prompt;
    if (isCreatingToken) {
      prompt = Prompts.createGameProductPrompt(
        projectName: projectName,
        description: description,
        tokenName: name.isNotEmpty ? name : "Unnamed Token",
        tokenSymbol: tokenSymbol,
        tokenFunctionality: functionality,
        priceRatio: priceRatio,
      );
    } else {
      prompt = Prompts.createGameItemPrompt(
        projectName: projectName,
        description: description,
        nftName: name.isNotEmpty ? name : "Unnamed NFT",
        nftFunctionality: functionality,
        priceRatio: priceRatio,
      );
    }

    // Send to AI Chatbot
    messagesViewModel.setMessageText(prompt);

    // Clear fields after submission
    nameController.clear();
    descriptionController.clear();
    functionalityController.clear();
    priceRatioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: handleCreateToken,
                  child: Text("Create Game Product (Token)", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCreatingToken ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: handleCreateNFT,
                  child: Text("Create Game Item (NFT)",  style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isCreatingToken ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              isCreatingToken ? "Create Game Product (Token)" : "Create Game Item (NFT)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: functionalityController,
              decoration: InputDecoration(labelText: "Functionality in the project"),
            ),
            TextField(
              controller: priceRatioController,
              decoration: InputDecoration(labelText: "Price Ratio (to main token)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleSubmit(context),
              child: Text("Submit To Assistant"),
            ),
          ],
        ),
      ),
    );
  }
}
