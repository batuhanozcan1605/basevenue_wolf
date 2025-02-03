import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? walletAddress; // Wallet connection state

  void connectWallet() {
    setState(() {
      walletAddress = "0xAb...1234"; // Simulated wallet address
    });
  }

  void disconnectWallet() {
    setState(() {
      walletAddress = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.cyanAccent,
                  child: const Text(
                    'LOGO',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                walletAddress == null
                    ? ElevatedButton(
                  onPressed: connectWallet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Connect Wallet',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'disconnect') {
                      disconnectWallet();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          walletAddress!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'disconnect',
                      child: Text('Disconnect Wallet'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Slogan Box
                  Expanded(
                    child: Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'SLOGAN',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Example Images Box
                  Expanded(
                    child: Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'Example Usage Images',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
