import 'package:basevenue_wolf/basevenue_wolf/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

enum MenuItem {
  projectName,
  platformWallet,
  tokenManagement,
  products,
  transactions,
  aiInsights,
}

class MainViewModel extends ChangeNotifier {
  String? walletAddress;

  bool get isConnected => walletAddress != null;
  bool get isMetaMaskAvailable => ethereum != null;

  MenuItem _selectedMenu = MenuItem.projectName;
  MenuItem get selectedMenu => _selectedMenu;

  void updateMenu(MenuItem menu) {
  _selectedMenu = menu;
  notifyListeners();
  }


  Future<void> connectWallet(BuildContext context) async {
    if (ethereum != null) { // Check if MetaMask (or similar) is available
      try {
        final accounts = await ethereum!.requestAccount(); // Request account access
        walletAddress = accounts.first; // Store the connected address
        notifyListeners();

        debugPrint("Connected Wallet Address (Public Key): $walletAddress");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connected Wallet: $walletAddress"),
            duration: const Duration(seconds: 3),
            backgroundColor: ColorPalette.primary,
          ),
        );

        // Redirect after connection
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } catch (e) {
        debugPrint("Error connecting wallet: $e");
      }
    } else {
      debugPrint("MetaMask not available");
    }
  }

  void disconnectWallet() {
      walletAddress = null;
      notifyListeners();
  }


}
