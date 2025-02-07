import 'dart:math';
import 'package:basevenue_wolf/basevenue_wolf/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../consts.dart';
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
    String tokenSymbol = name.isNotEmpty ? name.toUpperCase() : "TKN";

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
      backgroundColor: ColorPalette.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 88),
            Text("Products Page",
                style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
              softWrap: false, // Prevents automatic line wrapping
              overflow: TextOverflow.fade,
            ),
            SizedBox(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: handleCreateToken,
                    child: Text("Create Game Product (Token)", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCreatingToken ? ColorPalette.primaryVariant : Colors.transparent, // Button background
                      side: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Border color & width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: handleCreateNFT,
                    child: Text("Create Game Item (NFT)",  style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isCreatingToken ? ColorPalette.primaryVariant : Colors.transparent, // Button background
                      side: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Border color & width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              isCreatingToken ? "Create Game Product (Token)" : "Create Game Item (NFT)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              softWrap: false, // Prevents automatic line wrapping
              overflow: TextOverflow.fade,
            ),
            SizedBox(height: 10),
            TextField(
              cursorColor: ColorPalette.primaryVariant,
              controller: nameController,
              style: TextStyle(color: Colors.white), // Text color inside the field
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Focused border
                ),
              ),
            ),
            SizedBox(height: 12), // Spacing between fields
            TextField(
              cursorColor: ColorPalette.primaryVariant,
              controller: descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              cursorColor: ColorPalette.primaryVariant,
              controller: functionalityController,
              style: TextStyle(color: Colors.white,),
              decoration: InputDecoration(
                labelText: "Functionality in the project",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              cursorColor: ColorPalette.primaryVariant,
              controller: priceRatioController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price Ratio (to main token)",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
                ),
              ),
            ),

            SizedBox(height: 20),
            GestureDetector(
                onTap: () => handleSubmit(context),
                child: Image.asset(submitButtonPath, height: 50)),
          ],
        ),
      ),
    );
  }
}
