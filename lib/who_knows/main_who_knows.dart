import 'package:basevenue_wolf/who_knows/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WhoKnows());
}

class WhoKnows extends StatelessWidget {
  const WhoKnows({super.key});

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
