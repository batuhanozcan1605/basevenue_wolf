import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basevenuewolf_sdk/basevenuewolf_sdk.dart';
import '../view_model/game_view_model.dart';
import 'main_screen.dart'; // Adjust the import path to your MainScreen file.

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasLoadedGameData = false;

  // Create an instance of your SDK.
  final BasevenueWolfSDK sdk = BasevenueWolfSDK();

  /// Loads game data from the SDK.
  /// For demonstration purposes, we assume you already have the user's wallet address.
  Future<Map<String, dynamic>> loadGameData() async {
    String walletAddress = "0xdb072374a9bbeba03ae9422ea21d93a4fe7504fd";

    // Retrieve token address via your SDK API.
    String tokenAddress = await sdk.getUserTokenAddress(walletAddress);
    debugPrint("tokenAddress ${tokenAddress}");
    // Retrieve token details from the blockchain.
    BigInt totalSupply = await sdk.getTokenTotalSupply(tokenAddress);
    String tokenSymbol = await sdk.getTokenSymbol(tokenAddress);
    debugPrint("supply: ${sdk.formatTotalSupply(totalSupply).toString()}");
    return {
      "tokenAddress": tokenAddress,
      "totalSupply": totalSupply,
      "tokenSymbol": tokenSymbol,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadGameData(), // Your method to load game data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a splash/loading screen while waiting.
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Handle errors gracefully.
          return Scaffold(
            body: Center(child: Text("Error loading game data")),
          );
        } else if (snapshot.hasData) {
          // Data is loaded.
          // Schedule the update and navigation only once.
          if (!_hasLoadedGameData) {
            _hasLoadedGameData = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final gameData = snapshot.data!;
              final tokenAddress = gameData["tokenAddress"] as String;
              final totalSupply = gameData["totalSupply"] as BigInt;
              final tokenSymbol = gameData["tokenSymbol"] as String;

              // Update the GameViewModel.
              Provider.of<GameViewModel>(context, listen: false).updateGameData(
                tokenAddress: tokenAddress,
                totalSupply: totalSupply,
                tokenSymbol: tokenSymbol,
              );

              // Navigate to the MainScreen.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            });
          }

          // Return a temporary loading screen while waiting for navigation.
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
