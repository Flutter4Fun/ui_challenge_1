import 'package:flutter/material.dart';
import 'package:ui_challenge_1/values/colors.dart';

import 'seat_models.dart';

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
      behavior: HitTestBehavior.opaque,
      onTap: onGridSeatClicked != null ? () { onGridSeatClicked(model); } : null,
      child: SeatCell(model.state),
    );
  }
}

class SeatCell extends StatelessWidget {
  static final double size = 12.5, margin = 4, radius = 2;
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
        );
        break;
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
        break;
      case SeatState.Available:
      case SeatState.Selected:
        return AvailableSeatCell(
          selected: state == SeatState.Selected,
        );
        break;
      default:
        throw ArgumentError();
    }
  }
}

class AvailableSeatCell extends ImplicitlyAnimatedWidget {
  final bool selected;

  const AvailableSeatCell({Key key, @required this.selected})
      : super(key: key, duration: const Duration(milliseconds: 150), curve: Curves.linear);

  @override
  _AvailableSeatCellState createState() => _AvailableSeatCellState();
}

class _AvailableSeatCellState extends AnimatedWidgetBaseState<AvailableSeatCell> {
  Tween<double> _scaleTween;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SeatCell.margin),
      width: SeatCell.size,
      height: SeatCell.size,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: widget.selected ? 0 : 1.2),
        borderRadius: BorderRadius.all(Radius.circular(SeatCell.radius)),
      ),
      child: Transform.scale(
        scale: _scaleTween.evaluate(animation),
        child: SelectedImage(),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _scaleTween = visitor(_scaleTween, widget.selected ? 1.0 : 0.0,
            (dynamic value) => Tween<double>(begin: widget.selected ? 1.0 : 0.0));
  }
}

class SelectedImage extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SeatCell.radius)),
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
  }
}
