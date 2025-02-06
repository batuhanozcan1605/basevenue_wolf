// main_screen.dart
import 'package:basevenue_wolf/basevenue_wolf/color_palette.dart';
import 'package:basevenue_wolf/basevenue_wolf/consts.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/menu_pages/platform_wallet.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/widgets/chat_input_field.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/widgets/chat_messages_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import '../view_model/main_view_model.dart';
import 'menu_pages/token_management_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Top navigation bar widget
  PreferredSizeWidget _buildTopNavBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          Image.asset(logoPath, height: 40),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text('Overview', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Charts', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Customers', style: TextStyle(color: Colors.black)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.circle,
              color: Colors.green,
              size: 12,
            ),
            label: const Text('Wallet', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // Left vertical menu widget
  Widget _buildSideMenu(BuildContext context) {
    final viewModel = prov.Provider.of<MainViewModel>(context, listen: false);

    return Container(
      width: 200,
      color: Colors.grey.shade200,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.construction),
            title: const Text("WHO KNOWS"),
            onTap: () => viewModel.updateMenu(MenuItem.projectName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text("Platform Wallet"),
            onTap: () => viewModel.updateMenu(MenuItem.platformWallet),
          ),
          ListTile(
            leading: const Icon(Icons.token),
            title: const Text("Token Management"),
            onTap: () => viewModel.updateMenu(MenuItem.tokenManagement),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Products"),
            onTap: () => viewModel.updateMenu(MenuItem.products),
          ),
          ListTile(
            leading: const Icon(Icons.insert_chart),
            title: const Text("Transactions"),
            onTap: () => viewModel.updateMenu(MenuItem.transactions),
          ),
          ListTile(
            leading: const Icon(Icons.insights),
            title: const Text("AI Insights"),
            onTap: () => viewModel.updateMenu(MenuItem.aiInsights),
          ),
        ],
      ),
    );
  }

  // Main dynamic content widget
  Widget _buildMainContent(BuildContext context) {
    return prov.Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        switch (viewModel.selectedMenu) {
          case MenuItem.projectName:
            return const Center(child: Text("Project Details Content"));
          case MenuItem.platformWallet:
            return const PlatformWalletPage();
          case MenuItem.tokenManagement:
            return const TokenManagementPage();
          case MenuItem.products:
            return const Center(child: Text("Products Content"));
          case MenuItem.transactions:
            return const Center(child: Text("Transactions Content"));
          case MenuItem.aiInsights:
            return const Center(child: Text("AI Insights Content"));
          }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTopNavBar(context),
      body: Row(
        children: [
          // Left vertical menu
          _buildSideMenu(context),

          // Main content area (Expands to fill available space)
          Expanded(
            child: _buildMainContent(context),
          ),

          // Chatbot Fixed on the Right
          _buildChatbot(),
        ],
      ),
    );
  }

  // AI Chatbot UI (Fixed to Right)
  Widget _buildChatbot() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width:  450, // Toggle width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Chatbot Header (Always Visible)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("🤖 AI Assistant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Chat Messages & Input (Fixes Overflow)
            Expanded(
              child: Column(
                children: [
                  Expanded( // Makes messages scrollable
                    child: ChatMessagesList(),
                  ),
                  const SizedBox(height: 10), // Space before input field
                  ChatInputField(),
                  const SizedBox(height: 10), // Padding at the bottom
                ],
              ),
            ),
        ],
      )
    );
  }
}
