// main_screen.dart
import 'package:basevenue_wolf/basevenue_wolf/color_palette.dart';
import 'package:basevenue_wolf/basevenue_wolf/consts.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/menu_pages/platform_wallet.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/menu_pages/products.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/widgets/chat_input_field.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/widgets/chat_messages_list.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/widgets/svg_icon.dart';
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
  /*PreferredSizeWidget _buildTopNavBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          Image.asset(logoPath, height: 40),
          const Spacer(),

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
  }*/

  // Left vertical menu widget
  Widget _buildSideMenu(BuildContext context) {
    return prov.Consumer<MainViewModel>(
      builder: (BuildContext context, viewModel, Widget? child) {
        return Container(
          width: 240,
          color: ColorPalette.secondaryBackground,
          child: ListView(
            children: [
              SizedBox(height: 30,),
              Image.asset(logoPath, height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 23),
                child: Divider(color: ColorPalette.light.withOpacity(0.5)),
              ),
              ListTile(
                leading: Image.asset("assets/images/who_knows/who_knows_icon.png", height: 35,),
                title: const Text("WHO KNOWS", style: TextStyle(color: Colors.white),),
                onTap: () => viewModel.updateMenu(MenuItem.projectName),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 23),
                child: Divider(color: ColorPalette.light.withOpacity(0.5)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero, // Remove default padding
                title: Row(
                  children: [
                    // Vertical Stripe
                    Container(
                      width: 4, // Adjust width as needed
                      height: 30, // Match icon height
                      color: viewModel.selectedMenu == MenuItem.platformWallet
                          ? ColorPalette.primary
                          : Colors.transparent, // Hide when not selected
                    ),
                    const SizedBox(width: 8), // Space between stripe and icon
                    // Icon
                    SvgIcon(
                      assetPath: walletPath,
                      color: viewModel.selectedMenu == MenuItem.platformWallet
                          ? ColorPalette.primary
                          : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8), // Space between icon and text
                    // Text
                    Text(
                      "Platform Wallet",
                      style: TextStyle(
                        color: viewModel.selectedMenu == MenuItem.platformWallet
                            ? ColorPalette.primary
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () => viewModel.updateMenu(MenuItem.platformWallet),
              ),

              ListTile(
                leading: SvgIcon(
                  assetPath: tokenPath,
                  color: viewModel.selectedMenu == MenuItem.tokenManagement ?
                  ColorPalette.primary : Colors.white,
                  size: 20,
                ),
                title: Text("Token Management",
                  style: TextStyle(
                    color: viewModel.selectedMenu == MenuItem.tokenManagement ?
                    ColorPalette.primary : Colors.white,
                  ),
                ),
                onTap: () => viewModel.updateMenu(MenuItem.tokenManagement),
              ),
              ListTile(
                leading: SvgIcon(
                  assetPath: productsPath,
                  color: viewModel.selectedMenu == MenuItem.products ?
                  ColorPalette.primary : Colors.white,
                  size: 20,
                ),
                title: Text("Products", style: TextStyle(
                  color: viewModel.selectedMenu == MenuItem.products ?
                  ColorPalette.primary : Colors.white,
                ),),
                onTap: () => viewModel.updateMenu(MenuItem.products),
              ),
              ListTile(
                leading: SvgIcon(
                  assetPath: transactionsPath,
                  color: viewModel.selectedMenu == MenuItem.transactions ?
                  ColorPalette.primary : Colors.white,
                  size: 20,
                ),
                title: Text("Transactions",
                  style: TextStyle(
                    color: viewModel.selectedMenu == MenuItem.transactions ?
                    ColorPalette.primary : Colors.white,
                  ),
                ),
                onTap: () => viewModel.updateMenu(MenuItem.transactions),
              ),
              ListTile(
                leading: SvgIcon(
                  assetPath: aiInsightsPath,
                  color: viewModel.selectedMenu == MenuItem.aiInsights ?
                  ColorPalette.primary : Colors.white,
                  size: 20,
                ),
                title: Text("AI Insights",
                  style: TextStyle(
                    color: viewModel.selectedMenu == MenuItem.aiInsights ?
                    ColorPalette.primary : Colors.white,
                  ),
                ),
                onTap: () => viewModel.updateMenu(MenuItem.aiInsights),
              ),
            ],
          ),
        );
      },
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
            return const ProductsPage();
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
      backgroundColor: ColorPalette.background,
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
