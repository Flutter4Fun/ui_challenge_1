import 'package:flutter/material.dart';
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
              SeatsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}