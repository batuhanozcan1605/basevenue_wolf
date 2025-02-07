import 'package:basevenue_wolf/basevenue_wolf/view/main_screen.dart';
import 'package:basevenue_wolf/basevenue_wolf/view/landing_page.dart';
import 'package:basevenue_wolf/basevenue_wolf/view_model/main_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'basevenue_wolf/view_model/messages_view_model.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
          home: LandingPage(),
            routes: {
              '/home': (context) => MainScreen(),
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),
              fontFamily: 'Hellix',
            ),
        ),
      ),
    );
  }
}
