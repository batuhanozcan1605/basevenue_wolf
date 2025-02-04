import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // A helper widget for section headers.
  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // A helper widget for cards with a simple border.
  Widget cardContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            // Logo
            const Text(
              'Logo',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Navigation items
            TextButton(
              onPressed: () {},
              child: const Text("Home", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child:
              const Text("Projects", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Transactions",
                  style: TextStyle(color: Colors.black)),
            ),
            // Wallet indicator button
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.circle, color: Colors.green, size: 12),
              label: const Text("Wallet",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome row and primary action buttons
              cardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back, 0xAb...1234!",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text("Create Project"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.bar_chart),
                          label: const Text("View Transactions"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Your Projects Section
              sectionHeader("🏗️ Your Projects"),
              cardContainer(
                child: Column(
                  children: [
                    // Project 1 row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Project 1"),
                        const Text("3 Products"),
                        const Text("\$5,000 Revenue"),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("View"),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Project 2 row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Project 2"),
                        const Text("7 Products"),
                        const Text("\$12,300 Revenue"),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("View"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Platform Wallet Section
              sectionHeader("💰 Platform Wallet (AI-Managed)"),
              cardContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.link),
                          label: const Text("Bridge Tokens"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Transfer Funds"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.account_balance),
                          label: const Text("Treasury"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text("Token Balance: 10,000 \$TOKEN"),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text("Recent Tx: ✅ Sent 100 \$TOKEN to 0x456...def"),
                      ],
                    ),
                  ],
                ),
              ),
              // Main Token Management Section
              sectionHeader("🏆 Main Token Management"),
              cardContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Mint New Tokens"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("AI-Controlled Tokeneconomics"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text("🔹 Total Supply: 1,000,000 \$TOKEN"),
                    const SizedBox(height: 5),
                    const Text("🔹 AI-adjusted Inflation Rate: 2.5%"),
                    const SizedBox(height: 5),
                    const Text("🔹 Minting Status: ✅ Active"),
                  ],
                ),
              ),
              // AI Insights Section
              sectionHeader("🤖 AI Insights"),
              cardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("🔥 AI adjusted Tokeneconomics parameters today!"),
                    SizedBox(height: 5),
                    Text("💡 NFT Sales increased by 15% in the last week!"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
