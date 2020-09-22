import 'package:flutter/material.dart';
import 'package:ui_challenge_1/values/numbers.dart';

import 'seats_grid.dart';

class SelectedSeatsWidget extends StatelessWidget {
  final List<SeatModel> items;

  const SelectedSeatsWidget({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'YOUR SELECTED SEATS :',
              style: TextStyle(
                color: Colors.white,
                fontSize: appDefaultFontSizes,
              ),
            ),
          ),
        ),
        SizedBox(height: 16,),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.transparent,
            ),
            itemBuilder: (context, index) => SelectedSeatItemWidget(model: items[index]),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}

class SelectedSeatItemWidget extends StatelessWidget {
  final SeatModel model;

  const SelectedSeatItemWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      color: Color(0xff0F1143),
      child: Row(
        children: [
          SeatCell(SeatState.Selected),
          SizedBox(width: 6,),
          Text('ROW ${getRowSymbol(model.row)}, SEAT ${model.column}', style: TextStyle(color: Colors.white,),),
          Expanded(child: Container()),
          Text('${model.price.toDouble().toStringAsFixed(2)} \$', style: TextStyle(color: Colors.white,),),
        ],
      ),
    );
  }

  getRowSymbol(int row) => 'ABCDEFGH'[row];
}