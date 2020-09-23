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