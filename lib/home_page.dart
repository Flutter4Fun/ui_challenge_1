import 'package:flutter/material.dart';
import 'package:ui_challenge_1/widgets/seats_grid.dart';
import 'colors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Center(
          child: SeatsGrid(),
        ),
      ),
    );
  }
}
