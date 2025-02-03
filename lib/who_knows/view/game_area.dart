import 'package:basevenue_wolf/who_knows/consts.dart';
import 'package:basevenue_wolf/who_knows/widgets/clue_expansion_tile.dart';
import 'package:basevenue_wolf/who_knows/widgets/reward_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_palette.dart';
import '../widgets/custom_button.dart';

class GameArea extends StatelessWidget {
  const GameArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 488,
        height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 36,),
          RewardCard(),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClueExpansionTile(title: "STEP 1",
                      clue: "I am a mythological creature that is a combination of two animals."),
                  SizedBox(height: 20,),
                  ClueExpansionTile(title: "STEP 2",
                      clue: "I am the country where that creature\'s roots in step 1 originate."),
                  SizedBox(height: 20,),
                  ClueExpansionTile(title: 'STEP 3',
                      clue: "I am the ghost-nicknamed region in that country.")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Your answer...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
