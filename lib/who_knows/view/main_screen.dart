import 'package:basevenue_wolf/who_knows/view/game_area.dart';
import 'package:basevenue_wolf/who_knows/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_palette.dart';
import '../consts.dart';
import '../widgets/left_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: _appBar(),
      body: Row(
        children: [
          LeftDrawer(),
          SizedBox(width: 200.w,),
          GameArea(),
        ],
      ),
    );
  }
}




PreferredSizeWidget _appBar() => PreferredSize(
  preferredSize: const Size.fromHeight(100), // Set height to 100
  child: AppBar(
    toolbarHeight: 100,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 96.0),
          child: Image.asset(
            "assets/images/who_knows/who_knows_logo.png",
            height: 50,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 96.0),
        child: SizedBox(
          width: 180,
          child: CustomButton(
            imagePath: yellowButtonPath,
            text: "Connect your Wallet",
            textColor: Colors.black,
          ),
        ),
      )
    ],
  ),
);



