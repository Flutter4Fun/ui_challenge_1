import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge_1/values/colors.dart';

class TotalPrice extends ImplicitlyAnimatedWidget {
  final int price;

  const TotalPrice({Key key, @required this.price})
      : super(
          key: key,
          duration: const Duration(milliseconds: 200),
        );

  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends AnimatedWidgetBaseState<TotalPrice> {
  IntTween _tween;

  @override
  Widget build(BuildContext context) {
    return Text(
      'TOTAL: ${_tween.evaluate(animation)} \$',
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _tween = visitor(
      _tween,
      widget.price,
      (dynamic value) => IntTween(
        begin: value,
      ),
    );
  }
}
