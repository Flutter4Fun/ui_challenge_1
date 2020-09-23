import 'package:flutter/material.dart';

import 'seat_cell.dart';
import 'seat_models.dart';

class SeatsGrid extends StatefulWidget {
  final List<List<SeatModel>> seatsList;

  final Function(List<SeatModel>) onSelectedSeatsChanged;

  SeatsGrid({
    Key key,
    @required this.seatsList,
    this.onSelectedSeatsChanged,
  }) : super(key: key);

  @override
  _SeatsGridState createState() => _SeatsGridState();
}

class _SeatsGridState extends State<SeatsGrid> {
  List<SeatModel> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    final rows = widget.seatsList
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
    return seats
        .map((seatModel) => GridSeatCell(
      model: seatModel,
      onGridSeatClicked: (model) {
        if (model.state == SeatState.Available) {
          onSelect(model);
        } else if (model.state == SeatState.Selected) {
          onDeselect(model);
        }
      },
    ))
        .toList();
  }

  void onDeselect(SeatModel model) {
    selectedSeats.remove(widget.seatsList[model.row][model.column]);
    widget.seatsList[model.row][model.column] =
        SeatModel(SeatState.Available, model.row, model.column, model.price);

    if (widget.onSelectedSeatsChanged != null) {
      widget.onSelectedSeatsChanged(selectedSeats);
    }
  }

  void onSelect(SeatModel model) {
    widget.seatsList[model.row][model.column] =
        SeatModel(SeatState.Selected, model.row, model.column, model.price);
    selectedSeats.add(widget.seatsList[model.row][model.column]);

    if (widget.onSelectedSeatsChanged != null) {
      widget.onSelectedSeatsChanged(selectedSeats);
    }
  }
}