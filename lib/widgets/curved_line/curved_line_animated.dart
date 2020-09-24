import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_challenge_1/values/colors.dart';

import 'curved_line_widget.dart';

class AnimatedCurveLine extends StatefulWidget {

  final List<Color> colorsToAnimate;

  const AnimatedCurveLine({Key key, @required this.colorsToAnimate}) : super(key: key);

  @override
  _CurvedLineAnimatedWidgetState createState() => _CurvedLineAnimatedWidgetState();
}

class _CurvedLineAnimatedWidgetState extends State<AnimatedCurveLine>
  with TickerProviderStateMixin {

  AnimationController _controller;
  List<Color> _remainingColors;

  ColorTween _colorTween;

  @override
  void initState() {
    super.initState();
    refillColors();
    animateToNextColor();
  }

  void refillColors() => _remainingColors = List.of(widget.colorsToAnimate);

  void animateToNextColor() {
    final newTargetColor = _remainingColors.getRandom();
    _remainingColors.remove(newTargetColor);

    Color previousColor;
    if (_controller != null) {
      previousColor = _colorTween.evaluate(_controller);
    } else {
      previousColor = Colors.transparent;
    }

    _controller = new AnimationController(vsync: this, duration: getRandomDuration());
    _controller.forward(from: 0);
    _colorTween = new ColorTween(begin: previousColor, end: newTargetColor);
    _controller.addStatusListener(onAnimationStatusChanged);
    _controller.addListener(() {
      setState(() {

      });
    });
  }

  Duration getRandomDuration({int millsFrom = 300, int millsTo = 500}) {
    final randomMills = Random().nextInt(millsTo - millsFrom) + millsFrom;
    return Duration(milliseconds: randomMills);
  }

  void onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (_remainingColors.isEmpty) {
        refillColors();
      }
      animateToNextColor();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = _colorTween.evaluate(_controller);
    return CurvedLineWidget(
      lineThickness: 6,
      lineColor: color,
      gradientHeight: 42,
      gradientColors: [color.withOpacity(0.35), color.withOpacity(0)],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

extension ColorsList on List<Color> {

  Color getRandom() => this[Random().nextInt(this.length)];

}