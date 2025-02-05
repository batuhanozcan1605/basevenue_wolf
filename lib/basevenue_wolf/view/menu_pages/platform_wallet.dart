import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallet Overview
          const Text("📂 Platform Wallet", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Balance Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildBalanceCard("🔹 Wallet Balance", "$tokenBalance TOKEN"),
              buildBalanceCard("🔹 ETH Balance", "$ethBalance ETH"),
              buildBalanceCard("🔹 Treasury Reserve", "\$$treasuryReserve"),
            ],
          ),

          const SizedBox(height: 30),

          // Bridge & Transfer Section
          const Text("🔀 Bridge & Transfer Funds", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {}, // TODO: Add bridge function
                icon: const Icon(Icons.link),
                label: const Text("Bridge Tokens"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {}, // TODO: Add transfer function
                icon: const Icon(Icons.send),
                label: const Text("Send Payment"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Transaction History
          const Text("📊 Transaction History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Card(
                  child: ListTile(
                    title: Text(tx["amount"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("From: ${tx["from"]}"),
                    trailing: Text(tx["status"]!, style: TextStyle(color: tx["status"] == "✅ Success" ? Colors.green : Colors.orange)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget for balance display
  Widget buildBalanceCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 20, color: Colors.blueAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
