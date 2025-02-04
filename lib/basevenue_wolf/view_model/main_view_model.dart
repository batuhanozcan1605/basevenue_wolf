import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MainViewModel extends ChangeNotifier {
  String? walletAddress;

  bool get isConnected => walletAddress != null;
  bool get isMetaMaskAvailable => ethereum != null;

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
            backgroundColor: Colors.green,
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
