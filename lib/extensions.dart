import 'package:ui_challenge_1/widgets/seats_grid.dart';

extension SelectedSeatsListExtension on List<SeatModel> {
  int totalPrice() => map((model) => model.price).reduce((a, b) => a + b);
}