import 'package:flutter/material.dart';
import 'file:///D:/Dev/Flutter/Projects/UI-Challenge-1/lib/values/colors.dart';
import 'package:ui_challenge_1/values/numbers.dart';

enum SeatState {
  Available,
  Selected,
  Reserved,
  None,
}

class SeatModel {
  final SeatState state;
  final int row, column;
  final int price;

  SeatModel(
    this.state,
    this.row,
    this.column,
    this.price,
  );

}

class SeatsGrid extends StatefulWidget {
  final Function(List<SeatModel>) onSelectedSeatsChanged;

  final List<List<SeatModel>> initialModels = getSampleSeats();

  SeatsGrid({Key key, this.onSelectedSeatsChanged}) : super(key: key);

  @override
  _SeatsGridState createState() => _SeatsGridState();
}

class _SeatsGridState extends State<SeatsGrid> {
  List<List<SeatModel>> showingSeats;
  List<SeatModel> selectedSeats = [];

  @override
  void initState() {
    showingSeats = widget.initialModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rows = showingSeats
        .map((columnsSeat) => Row(
              children: makeColumns(columnsSeat),
              mainAxisSize: MainAxisSize.min,
            ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }

  List<Widget> makeColumns(List<SeatModel> seats) {
    return seats.map((seatModel) => GridSeatCell(model: seatModel, onGridSeatClicked: (model) {
      if (model.state == SeatState.Available) {
        onDeselect(model);
      } else if (model.state == SeatState.Selected) {
        onSelect(model);
      }
    },)).toList();
  }

  void onDeselect(SeatModel model) {
    selectedSeats.remove(showingSeats[model.row][model.column]);
    showingSeats[model.row][model.column] = SeatModel(SeatState.Selected, model.row, model.column, model.price);

    if (widget.onSelectedSeatsChanged != null) {
      widget.onSelectedSeatsChanged(selectedSeats);
    }
  }

  void onSelect(SeatModel model) {
    showingSeats[model.row][model.column] = SeatModel(SeatState.Available, model.row, model.column, model.price);
    selectedSeats.add(showingSeats[model.row][model.column]);

    if (widget.onSelectedSeatsChanged != null) {
      widget.onSelectedSeatsChanged(selectedSeats);
    }
  }
}

List<List<SeatModel>> getSampleSeats() {
  const int none = 0, available = 1, reserved = 2, selected = 3;
  final states = [
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0],
    [1, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 1],
    [1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2],
    [1, 1, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 2],
    [0, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 0],
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

  List<List<SeatModel>> gridSeats = List(states.length);

  for (int row = 0; row < states.length; row++) {
    gridSeats[row] = List(states[row].length);
    for (int col = 0; col < states[row].length; col++) {
      gridSeats[row][col] = SeatModel(states[row][col], row, col, 60);
    }
  }

  return gridSeats;
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

class GridSeatCell extends StatelessWidget {
  final Function(SeatModel) onGridSeatClicked;
  final SeatModel model;

  const GridSeatCell({
    Key key,
    @required this.model,
    this.onGridSeatClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap');
        onGridSeatClicked(model);
      },
      child: SeatCell(model.state),
    );
  }
}

class SeatCell extends StatelessWidget {
  final double size = 12.5, margin = 4, radius = 2;
  final SeatState state;

  const SeatCell(this.state);

  @override
  Widget build(BuildContext context) {
    Widget cell;
    switch (state) {
      case SeatState.None:
        cell = Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          color: Colors.transparent,
        );
        break;
      case SeatState.Available:
        cell = Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1.2),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        );
        break;
      case SeatState.Reserved:
        cell = Container(
          margin: EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: primaryColor,
          ),
        );
        break;
      case SeatState.Selected:
        cell = Container(
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
        break;
      default:
        throw ArgumentError();
    }
    return GestureDetector(
      onTap: () {},
      child: cell,
    );
  }
}
