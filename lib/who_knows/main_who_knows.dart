import 'package:basevenue_wolf/who_knows/view/main_screen.dart';
import 'package:basevenue_wolf/who_knows/view/splash_screen.dart';
import 'package:basevenue_wolf/who_knows/view_model/game_view_model.dart';
import 'package:basevenuewolf_sdk/basevenuewolf_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sdk = BasevenueWolfSDK();
  String userWalletAddress = "0xdb072374a9bbeba03ae9422ea21d93a4fe7504fd";
  String tokenContractAddress = await sdk.getUserTokenAddress(userWalletAddress);
  //print("tokenContractAddress $tokenContractAddress");
  //String tokenContractAddress = "0xa751b5c2b8078e5cb0fd4f36088165b368b3fd11";
  String tokenName = await sdk.getTokenName(tokenContractAddress);

  BigInt rawBalance = await sdk.getTokenBalance(tokenContractAddress, userWalletAddress);
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: Size(1280, 800), // Logical resolution for MacBook M1 (13-inch)
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Hellix',
          )
        ),
      ),
    );
  }
}
