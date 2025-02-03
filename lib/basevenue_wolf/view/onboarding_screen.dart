import 'package:basevenue_wolf/basevenue_wolf/consts.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? walletAddress;
  late WalletConnect connector;

  @override
  void initState() {
    super.initState();
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'YourDapp',
        description: 'A Web3 Flutter DApp',
        url: 'https://yourdapp.com',
        icons: ['https://yourdapp.com/icon.png'],
      ),
    );
  }

  Future<void> connectWallet() async {
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 1, // Ethereum Mainnet
        onDisplayUri: (uri) async {
          Uri walletUri = Uri.parse(uri);
          if (await canLaunchUrl(walletUri)) {
            await launchUrl(walletUri, mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch wallet URL';
          }
        },
      );

      setState(() {
        walletAddress = session.accounts[0];
      });

      if (walletAddress != null) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo / Illustration
            Image.asset(logoPath, height: 120), // Replace with your logo

            const SizedBox(height: 30),

            // Title
            const Text(
              "Welcome to BasevenueCat",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Connect your wallet to start exploring decentralized features securely.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Connect Wallet Button
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
                'Connect Wallet',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Wallet address display (if connected)
            if (walletAddress != null) ...[
              Text(
                "Connected: ${walletAddress!.substring(0, 6)}...${walletAddress!.substring(walletAddress!.length - 4)}",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    walletAddress = null;
                    connector.killSession();
                  });
                },
                child: const Text("Disconnect", style: TextStyle(color: Colors.redAccent)),
              )
            ],
          ],
        ),
      ),
    );
  }
}
