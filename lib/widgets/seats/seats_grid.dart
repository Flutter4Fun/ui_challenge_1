import 'package:flutter/material.dart';
import 'package:ui_challenge_1/bloc/bloc.dart';
import 'package:ui_challenge_1/bloc/seats_bloc.dart';
import 'seat_cell.dart';

class SeatsGrid extends StatefulWidget {
  @override
  _SeatsGridState createState() => _SeatsGridState();
}

class _SeatsGridState extends State<SeatsGrid> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<SeatsBloc>(context).onAnythingChanged(),
      builder: (context, snapshot) {
        final allSeats = BlocProvider.of<SeatsBloc>(context).getAllSeatsState();
        final rows = allSeats.map((columnsSeat) => Row(
          children: makeColumns(columnsSeat),
          mainAxisSize: MainAxisSize.min,
        )).toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: rows,
        );
      }
    );
  }

  List<Widget> makeColumns(List<SeatModel> seats) {
    return seats.map((seatModel) => GridSeatCell(
      model: seatModel,
      onGridSeatClicked: (model) {
        if (model.state == SeatState.Available) {
          onSelect(model);
        } else if (model.state == SeatState.Selected) {
          onDeselect(model);
        }
      },
    )).toList();
  }

  void onDeselect(SeatModel model) => BlocProvider.of<SeatsBloc>(context).removeItem(model);

  void onSelect(SeatModel model) => BlocProvider.of<SeatsBloc>(context).addItem(model);
}