import 'package:flutter/material.dart';

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
    return seats.map((seatState) => makeSeat(seatState)).toList();
  }
}

Widget makeSeat(SeatState seat) {
  double size = 12, margin = 4, radius = 2;
  switch (seat) {
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
          border: Border.all(color: Colors.blue),
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
          color: Colors.blue,
        ),
      );
    case SeatState.Selected:
      return Container(
        margin: EdgeInsets.all(margin),
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: Colors.purple,
        ),
      );
    default: throw ArgumentError();
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
  ].map((row) => row.map((columnNumber) {
            SeatState state;
            switch (columnNumber) {
              case none: state = SeatState.None; break;
              case available: state = SeatState.Available; break;
              case reserved: state = SeatState.Reserved; break;
              case selected: state = SeatState.Selected; break;
            }
            return state;
          }).toList())
      .toList();
}
