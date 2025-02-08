import 'package:intl/intl.dart';
import 'dart:math';

class Utilities {

  static String formatTotalSupply(BigInt rawSupply, {int decimals = 18}) {
    print("rawSupply $rawSupply");
    // Convert BigInt to double value based on token decimals.
    double supplyValue = rawSupply / BigInt.from(pow(10, decimals));

    // Use NumberFormat to add commas (no decimal places)
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(supplyValue);
  }

}