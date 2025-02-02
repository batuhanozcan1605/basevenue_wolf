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
      home: Scaffold(
        appBar: AppBar(title: Text('Hello, Flutter!')),
        body: Center(child: Text('Welcome to Flutter')),
      ),
    );
  }
}
