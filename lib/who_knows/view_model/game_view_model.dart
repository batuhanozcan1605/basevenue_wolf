import 'package:flutter/material.dart';

class GameViewModel extends ChangeNotifier {
  String? tokenAddress;
  BigInt? totalSupply;
  String? tokenSymbol;

  // You can add setters if needed:
  void updateGameData({
    required String tokenAddress,
    required BigInt totalSupply,
    required String tokenSymbol,
  }) {
    this.tokenAddress = tokenAddress;
    this.totalSupply = totalSupply;
    this.tokenSymbol = tokenSymbol;
    notifyListeners();
  }
}
