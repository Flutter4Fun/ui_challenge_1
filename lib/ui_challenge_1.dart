import 'package:flutter/material.dart';
import 'package:ui_challenge_1/bloc/bloc.dart';
import 'package:ui_challenge_1/bloc/seats_bloc.dart';
import 'package:ui_challenge_1/widgets/curved_line/curved_line_animated.dart';
import 'package:ui_challenge_1/widgets/total_price.dart';
import 'values/colors.dart';
import 'widgets/header_section.dart';
import 'widgets/seats/seats_grid.dart';
import 'widgets/seats/seats_guide.dart';
import 'widgets/seats/selected_seats.dart';
import 'bloc/seats_bloc.dart';
import 'extensions.dart';

class UiChallenge1 extends StatefulWidget {
  @override
  _UiChallenge1State createState() => _UiChallenge1State();
}

class _UiChallenge1State extends State<UiChallenge1> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeatsBloc>(
      blocBuilder: () => SeatsBloc(),
      child: Builder(
        builder: (context) {
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
                      child: AnimatedCurveLine(
                        colorsToAnimate: [
                          sceneColor1,
                          sceneColor2,
                          sceneColor3,
                          sceneColor4
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SeatsGrid(),
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
                      child: SelectedSeatsWidget(),
                    ),
                    StreamBuilder(
                      stream: BlocProvider.of<SeatsBloc>(context).onAnythingChanged(),
                      builder: (context, value) {
                        final seatsBloc = BlocProvider.of<SeatsBloc>(context);
                        final selectedItems = seatsBloc.getSelectedItems();
                        return Column(
                          children: [
                            if (selectedItems.isNotEmpty)
                              ...[
                                SizedBox(height: 4,),
                                TotalPrice(price: selectedItems.totalPrice()),
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
                                onPressed: selectedItems.isNotEmpty ? () {
                                  setState(() {
                                    seatsBloc.clearAllItems();
                                  });
                                } : null,
                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                color: accentColor,
                                disabledColor: accentColor.withOpacity(0.1),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}