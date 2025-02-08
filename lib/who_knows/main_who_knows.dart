import 'package:basevenue_wolf/who_knows/view/main_screen.dart';
import 'package:basevenuewolf_sdk/basevenuewolf_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sdk = BasevenueWolfSDK();
  //String userWalletAddress = "0xdb7069c7261dce92938849c099BCc4a48ce92E96";
  //String tokenContractAddress = await sdk.getUserTokenAddress(userWalletAddress);
  //print("tokenContractAddress $tokenContractAddress");
  String tokenContractAddress = "0xfeaee5516b75566326f926330932b537d9ef2892";
  String tokenName = await sdk.getTokenName(tokenContractAddress);
  String ownerAddress = '0xdb7069c7261dce92938849c099BCc4a48ce92E96';
  BigInt rawBalance = await sdk.getTokenBalance(tokenContractAddress, ownerAddress);
  print("Token Name: $tokenName");

  String formattedBalance = sdk.formatTokenBalance(rawBalance);
  print("Formatted Balance: $formattedBalance");
  runApp(WhoKnows());
}

class WhoKnows extends StatelessWidget {
  WhoKnows({super.key});

  final sdk = BasevenueWolfSDK();

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(1280, 800), // Logical resolution for MacBook M1 (13-inch)
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Hellix',
        )
      ),
    );
  }
}
