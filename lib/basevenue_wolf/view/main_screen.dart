// main_screen.dart
import 'package:basevenue_wolf/basevenue_wolf/color_palette.dart';
import 'package:basevenue_wolf/basevenue_wolf/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import '../view_model/main_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Top navigation bar widget
  PreferredSizeWidget _buildTopNavBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.darkBackground,
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
            return const Center(child: Text("Platform Wallet Content"));
          case MenuItem.tokenManagement:
            return const Center(child: Text("Token Management Content"));
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

  // Bottom welcome panel widget
  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Welcome back, 0xAb...1234!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("Your AI agent is optimizing tokenomics!"),
        ],
      ),
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
          // Main content area
          Expanded(
            child: _buildMainContent(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomPanel(),
    );
  }
}
