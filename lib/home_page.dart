import 'package:flutter/material.dart';
import 'package:ui_challenge_1/widgets/curved_line_widget.dart';
import 'package:ui_challenge_1/widgets/total_price.dart';
import 'values/colors.dart';
import 'widgets/header_section.dart';
import 'widgets/seats/seat_models.dart';
import 'widgets/seats/seats_grid.dart';
import 'widgets/seats/seats_guide.dart';
import 'widgets/seats/selected_seats.dart';
import 'extensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SeatModel> selectedSeats = [];
  List<List<SeatModel>> seatsList = [];

  @override
  void initState() {
    super.initState();
    seatsList = getSampleSeats();
  }

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
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: CurvedLineWidget(
                  lineThickness: 6,
                  lineColor: sceneColor1,
                  gradientHeight: 42,
                  gradientColors: [sceneColor1.withOpacity(0.35), sceneColor1.withOpacity(0)],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SeatsGrid(
                seatsList: seatsList,
                onSelectedSeatsChanged: (newSelectedSeats) {
                  setState(() {
                    selectedSeats = newSelectedSeats;
                  });
                },
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                height: 0.7,
                color: Color(0xffA2A2A2).withOpacity(0.3),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SeatsGuideWidget(),
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: selectedSeats.isNotEmpty ? SelectedSeatsWidget(items: selectedSeats) : Container(),
              ),
              if (selectedSeats.isNotEmpty)
                ...[
                  SizedBox(height: 4,),
                  TotalPrice(price: selectedSeats.totalPrice()),
                ],
              Container(
                width: double.infinity,
                height: 46,
                margin: EdgeInsets.only(left: 42, right: 42, top: 16, bottom: 22),
                child: RaisedButton(
                  child: Text(
                    "CONFIRM SEATS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: selectedSeats.isNotEmpty ? () {
                    setState(() {
                      selectedSeats.clear();
                      seatsList = getSampleSeats();
                    });
                  } : null,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: accentColor,
                  disabledColor: accentColor.withOpacity(0.1),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
