import 'package:basevenue_wolf/who_knows/view/main_screen.dart';
import 'package:basevenuewolf_sdk/basevenuewolf_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WhoKnows());
}

class WhoKnows extends StatelessWidget {
  WhoKnows({super.key});

  final sdk = BasevenueWolfSDK();

  @override
  Widget build(BuildContext context) {

    String dummyAddress = sdk.getDummyMainTokenAddress();
    print("Adress: $dummyAddress");

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
