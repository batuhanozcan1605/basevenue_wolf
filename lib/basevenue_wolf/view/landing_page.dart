import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../color_palette.dart';
import '../consts.dart';
import '../view_model/main_view_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        backgroundColor: ColorPalette.secondaryBackground,
        elevation: 0,
        title: Image.asset(logoPath, height: 40),
        actions: [
          _buildButton("Login", Colors.grey.shade800),
          const SizedBox(width: 10),
          _buildButton("Signup", ColorPalette.primary),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Background Wolf & Moon Image
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              wolfMoonImagePath, // Ensure this is defined in consts.dart
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 96.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),

                // Title
                const Text(
                  "The Fastest Way to Bring",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Your Game to Web3",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: ColorPalette.primary),
                ),

                const SizedBox(height: 16),

                // Subtitle
                SizedBox(
                  child: Text(
                    "Lorem ipsum dolor sit amet consectetur. Donec pretium dui proin massa rhoncus eget. Viverra at feugiat ac tristique.",
                    style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                  ),
                ),

                const SizedBox(height: 24),

                // Wallet Connection Logic
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: viewModel.isMetaMaskAvailable
                          ? () async {
                        viewModel.connectWallet(context);
                      }
                          : null, // Disable tap if MetaMask is not available
                      child: Image.asset(walletButtonPath, height: 54),
                    ),

                    const SizedBox(height: 10),

                    // Show warning if no wallet is found
                    if (!viewModel.isMetaMaskAvailable)
                      const Text(
                        "We could not find any wallet in your browser.",
                        style: TextStyle(color: Colors.redAccent, fontSize: 14),
                      ),

                    // Show connected wallet address if connected
                    if (viewModel.isConnected) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.greenAccent),
                          const SizedBox(width: 8),
                          Text(
                            "Connected: ${viewModel.walletAddress!.substring(0, 6)}...${viewModel.walletAddress!.substring(viewModel.walletAddress!.length - 4)}",
                            style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),


                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
