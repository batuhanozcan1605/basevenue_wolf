import 'package:basevenue_wolf/basevenue_wolf/view/main_screen.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/onboarding_screen.dart';
import 'package:basevenue_wolf/basevenue_wolf/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'basevenue_wolf/view_model/messages_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BasevenueWolf());
}

class BasevenueWolf extends StatelessWidget {
  const BasevenueWolf({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => MessagesViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: Size(1440, 900), // Logical resolution for MacBook M1 (13-inch)
        minTextAdapt: true,
        child: MaterialApp(
            routes: {
              '/home': (context) => MainScreen(),
            },
            debugShowCheckedModeBanner: false,
            home: MainScreen(),
            theme: ThemeData(
              fontFamily: 'Hellix',
            )
        ),
      ),
    );
  }
}
