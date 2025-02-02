import 'package:flutter/material.dart';
import '../color_palette.dart';
import '../consts.dart';
import 'custom_button.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  int keyCount = 3;
  int featherCount = 3;
  final int keyPrice = 10;
  final int featherPrice = 5;

  void increaseKeys() {
    setState(() {
      keyCount++;
    });
  }

  void decreaseKeys() {
    if (keyCount > 0) {
      setState(() {
        keyCount--;
      });
    }
  }

  void increaseFeathers() {
    setState(() {
      featherCount++;
    });
  }

  void decreaseFeathers() {
    if (featherCount > 0) {
      setState(() {
        featherCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = (keyCount * keyPrice) + (featherCount * featherPrice);

    return Container(
      width: 330,
      color: ColorPalette.drawer,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 108),
      child: Column(
        children: [
          // Top Row with Key and Feather Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('0', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 4,),
                  Image.asset('assets/images/who_knows/key.png', height: 50),
                ],
              ),
              Row(
                children: [
                  Text('0', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 4,),
                  Image.asset('assets/images/who_knows/feather.png', height: 50),
                ],
              ),
            ],
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.white54, thickness: 1),
          ),

          // Key Purchase Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: decreaseKeys,
                    child: Image.asset('assets/images/who_knows/decrease.png', height: 30),
                  ),
                  SizedBox(width: 10),
                  Text('$keyCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: increaseKeys,
                    child: Image.asset('assets/images/who_knows/increase.png', height: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/images/who_knows/key.png', height: 50),
                  SizedBox(width: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$keyPrice ', // Feather price with size 24
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'WKNO', // WKNO with size 16
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Feather Purchase Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: decreaseFeathers,
                    child: Image.asset('assets/images/who_knows/decrease.png', height: 30),
                  ),
                  SizedBox(width: 10),
                  Text('$featherCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: increaseFeathers,
                    child: Image.asset('assets/images/who_knows/increase.png', height: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/images/who_knows/feather.png', height: 50),
                  SizedBox(width: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$featherPrice ', // Feather price with size 24
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'WKNO', // WKNO with size 16
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 30),

          // Total Price
          Text(
            'Total: $totalPrice WKNO',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          SizedBox(height: 20),

          // Purchase Button
          CustomButton(
            imagePath: yellowButtonPath,
            text: 'Purchase',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
