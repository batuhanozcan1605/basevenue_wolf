import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../color_palette.dart';
import '../../consts.dart';

class PlatformWalletPage extends StatefulWidget {
  const PlatformWalletPage({super.key});

  @override
  State<PlatformWalletPage> createState() => _PlatformWalletPageState();
}

class _PlatformWalletPageState extends State<PlatformWalletPage> {
  // Simulated wallet data
  double tokenBalance = 10000.0;
  double ethBalance = 0.5;
  double treasuryReserve = 5000.0;

  // Simulated transaction history
  final List<Map<String, String>> transactions = [
    {"status": "✅ Success", "amount": "100 TOKEN", "from": "0x123...abc"},
    {"status": "⏳ Pending", "amount": "50 USDC", "from": "0x456...def"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),

            // Wallet Overview Title
            const Text(
              "Platform Wallet",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            const SizedBox(height: 24),

            // Balance Cards
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildInfoCard("Wallet Balance", "$tokenBalance TOKEN"),
                    SizedBox(width: 16),
                    _buildInfoCard("ETH Balance", "$ethBalance ETH"),
                    SizedBox(width: 16),
                    _buildInfoCard("Treasury Reserve", "\$$treasuryReserve"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Bridge & Transfer Section
            const Text(
              "Bridge & Transfer Funds",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildActionButton("Bridge Tokens", Icons.link, ColorPalette.primaryVariant),
                const SizedBox(width: 16),
                _buildActionButton("Send Payment", Icons.send, Colors.green),
              ],
            ),

            const SizedBox(height: 30),

            // Transaction History
            const Text(
              "Transaction History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return _buildTransactionCard(tx["amount"]!, tx["from"]!, tx["status"]!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for balance display (matching card style)
  Widget _buildInfoCard(String title, String value) {
    return Stack(
      children: [
        Image.asset(
          gradientCardPath,
          height: 110.h,
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Action Buttons (Bridge & Send)
  Widget _buildActionButton(String text, IconData icon, Color color) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  // Transaction Card
  Widget _buildTransactionCard(String amount, String from, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorPalette.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(amount, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text("From: $from", style: TextStyle(color: Colors.white.withOpacity(0.7))),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(color: status == "✅ Success" ? Colors.green : Colors.orange, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
