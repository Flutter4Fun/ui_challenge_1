import 'package:flutter/material.dart';
import 'package:ui_challenge_1/values/numbers.dart';

class HeaderSection extends StatelessWidget {
  final double imageSize = 52;
  final double iconsSize = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color(0xFF00C4FF).withOpacity(0.7),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ]),
          child: Image.asset(
            'assets/joker.png',
            width: imageSize,
            height: imageSize,
            package: 'ui_challenge_1',
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JOKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: appDefaultFontSizes,
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Image.asset('assets/ic_calendar.png', width: iconsSize, height: iconsSize, package: 'ui_challenge_1',),
                    SizedBox(width: 8,),
                    Text('DECEMBER 04, 2020', style: TextStyle(color: Color(0xffA2A2A2), fontSize: appDefaultFontSizes),),
                    SizedBox(width: 16,),
                    Image.asset('assets/ic_time.png', width: iconsSize, height: iconsSize, package: 'ui_challenge_1',),
                    SizedBox(width: 8,),
                    Text('20:30', style: TextStyle(color: Color(0xffA2A2A2), fontSize: appDefaultFontSizes,),),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}