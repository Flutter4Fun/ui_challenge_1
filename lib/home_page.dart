import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'widgets/curved_line_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x060524),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
            child: CurvedLineWidget(),
          ),
        ),
      ),
    );
  }
}
