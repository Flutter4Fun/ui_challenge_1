import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge_1/widgets/curved_line_widget.dart';
import 'package:ui_challenge_1/widgets/seats_grid.dart';
import 'values/colors.dart';
import 'widgets/header_section.dart';
import 'widgets/selected_seats.dart';
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
                  Text(
                    'TOTAL: ${selectedSeats.totalPrice()} \$',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      )
                    ),
                  ),
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
