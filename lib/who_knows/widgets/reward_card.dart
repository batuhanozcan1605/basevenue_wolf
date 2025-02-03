import 'package:basevenue_wolf/who_knows/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_palette.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36),
      decoration: BoxDecoration(
        color: ColorPalette.orange.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Reward Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'REWARD :',
                style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 8),
              Text(
                '1',
                style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 4),
              Image.asset(badgePath, height: 30.h),
              SizedBox(width: 8),
              Text(
                '+ 1',
                style: TextStyle(fontSize:  24.h, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 4),
              Image.asset(keyPath, height: 30.h),
            ],
          ),
          SizedBox(height: 12),

          // Coin Conversion Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(badgePath, height: 30.h),
              SizedBox(width: 8),
              Image.asset(badgePath, height: 30.h),
              SizedBox(width: 8),
              Image.asset(badgePath, height: 30.h),
              SizedBox(width: 8),
              Text(
                '=',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 8),
              Image.asset(cupPath, height: 30.h),
              SizedBox(width: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '100 ',
                      style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'WKNO',
                      style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Badges:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 12),
              Image.asset(emptyBadgePath, height: 30.h),
              SizedBox(width: 8),
              Image.asset(emptyBadgePath, height: 30.h),
              SizedBox(width: 8),
              Image.asset(emptyBadgePath, height: 30.h,),
            ],
          ),
        ],
      ),
    );
  }
}
