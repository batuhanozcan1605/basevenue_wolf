import 'package:basevenue_wolf/basevenue_wolf/view/home_page.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BasevenueWolf());
}

class BasevenueWolf extends StatelessWidget {
  const BasevenueWolf({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1440, 900), // Logical resolution for MacBook M1 (13-inch)
      minTextAdapt: true,
      child: MaterialApp(
          routes: {
            '/home': (context) => HomePage(),
          },
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
          theme: ThemeData(
            fontFamily: 'Hellix',
          )
      ),
    );
  }
}
