import 'package:basevenue_wolf/who_knows/view/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WhoKnows());
}

class WhoKnows extends StatelessWidget {
  const WhoKnows({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Hellix',
      )
    );
  }
}
