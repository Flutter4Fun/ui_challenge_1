import 'package:flutter/material.dart';
import 'package:ui_challenge_1/bloc/seats_bloc.dart';
import 'package:ui_challenge_1/values/numbers.dart';
import 'package:ui_challenge_1/widgets/seats/seat_cell.dart';

class SeatsGuideWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        makeHint('SELECTED', SeatState.Selected),
        makeHint('RESERVED', SeatState.Reserved),
        makeHint('AVAILABLE', SeatState.Available),
      ],
    );
  }

  Widget makeHint(String text, SeatState state) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: appDefaultFontSizes,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        SeatCell(state),
      ],
    );
  }
}