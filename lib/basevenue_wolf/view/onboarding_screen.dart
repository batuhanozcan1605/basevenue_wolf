import 'package:basevenue_wolf/basevenue_wolf/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import '../consts.dart';
import 'package:provider/provider.dart' as prov;


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  @override
  Widget build(BuildContext context) {
    final viewModel = prov.Provider.of<MainViewModel>(context, listen: false);

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

            if (viewModel.isConnected) ...[
              Text(
                "Connected: ${viewModel.walletAddress!.substring(0, 6)}...${viewModel.walletAddress!.substring(viewModel.walletAddress!.length - 4)}",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: viewModel.disconnectWallet,
                child: const Text("Disconnect", style: TextStyle(color: Colors.redAccent)),
              ),
            ] else if (viewModel.isMetaMaskAvailable) ...[
              ElevatedButton(
                onPressed: ()
                async {
                  viewModel.connectWallet(context);
                },
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
