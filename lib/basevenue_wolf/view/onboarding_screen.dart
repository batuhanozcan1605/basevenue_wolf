import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../consts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? walletAddress;

  bool get isConnected => walletAddress != null;
  bool get isMetaMaskAvailable => ethereum != null;

  Future<void> connectWallet() async {
    if (isMetaMaskAvailable) {
      try {
        final accounts = await ethereum!.requestAccount(); // Request account access
        setState(() {
          walletAddress = accounts.first; // Store the connected address
        });

        debugPrint("Connected Wallet Address (Public Key): $walletAddress");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Connected Wallet: ${walletAddress!}"),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Redirect after connection
        if (walletAddress != null) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
      } catch (e) {
        print("Error connecting wallet: $e");
      }
    } else {
      print("MetaMask not available");
    }
  }

  void disconnectWallet() {
    setState(() {
      walletAddress = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => debugPrint("Logo is tapped"),
                child: Image.asset(logoPath, height: 120)), // Your logo

            const SizedBox(height: 30),

            const Text(
              "Welcome to BasevenueWolf",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Connect your MetaMask wallet to start exploring decentralized features securely.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 40),

            if (isConnected) ...[
              Text(
                "Connected: ${walletAddress!.substring(0, 6)}...${walletAddress!.substring(walletAddress!.length - 4)}",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: disconnectWallet,
                child: const Text("Disconnect", style: TextStyle(color: Colors.redAccent)),
              ),
            ] else if (isMetaMaskAvailable) ...[
              ElevatedButton(
                onPressed: connectWallet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Connect MetaMask',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ] else ...[
              const Text(
                "MetaMask not available. Please install MetaMask extension.",
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
