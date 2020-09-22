import 'package:flutter/material.dart';
import 'package:ui_challenge_1/colors.dart';

enum SeatState {
  Available,
  Selected,
  Reserved,
  None,
}

class SeatsGrid extends StatelessWidget {
  final List<List<SeatState>> seats = getSampleSeats();

  @override
  Widget build(BuildContext context) {
    final rows = seats
        .map((columnsSeatState) => Row(
              children: makeColumns(columnsSeatState),
              mainAxisSize: MainAxisSize.min,
            ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }

  List<Widget> makeColumns(List<SeatState> seats) {
    return seats.map((seatState) => SeatCell(seatState)).toList();
  }
}

List<List<SeatState>> getSampleSeats() {
  const int none = 0, available = 1, reserved = 2, selected = 3;
  return [
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0],
    [1, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 1],
    [1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2],
    [1, 1, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 2],
    [0, 1, 1, 2, 1, 1, 3, 3, 1, 2, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 0],
    [0, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 0],
  ]
      .map((row) => row.map((columnNumber) {
            SeatState state;
            switch (columnNumber) {
              case none:
                state = SeatState.None;
                break;
              case available:
                state = SeatState.Available;
                break;
              case reserved:
                state = SeatState.Reserved;
                break;
              case selected:
                state = SeatState.Selected;
                break;
            }
            return state;
          }).toList())
      .toList();
}

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
        Text(text, style: TextStyle(color: Colors.white),),
        SizedBox(width: 8,),
        SeatCell(state),
      ],
    );
  }

}

class SeatCell extends StatelessWidget {
  final double size = 12.5, margin = 4, radius = 2;
  final SeatState state;

  const SeatCell(this.state);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case SeatState.None:
        return Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          color: Colors.transparent,
        );
      case SeatState.Available:
        return Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1.2),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        );
      case SeatState.Reserved:
        return Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: primaryColor,
          ),
        );
      case SeatState.Selected:
        return Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: pink,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.8),
              child: Image.asset(
                'assets/ic_check.png',
              ),
            ),
          ),
        );
      default:
        throw ArgumentError();
    }
  }

}