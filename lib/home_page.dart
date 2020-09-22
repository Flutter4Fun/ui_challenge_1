import 'package:flutter/material.dart';
import 'package:ui_challenge_1/widgets/curved_line_widget.dart';
import 'package:ui_challenge_1/widgets/seats_grid.dart';
import 'colors.dart';
import 'widgets/header_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HeaderSection(),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: CurvedLineWidget(
                  lineThickness: 6,
                  lineColor: sceneColor1,
                  gradientHeight: 42,
                  gradientColors: [sceneColor1.withOpacity(0.35), sceneColor1.withOpacity(0)],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SeatsGrid(),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                height: 0.7,
                color: Color(0xffA2A2A2).withOpacity(0.3),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
