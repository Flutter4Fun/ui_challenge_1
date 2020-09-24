import 'bloc/seats_bloc.dart';

extension SelectedSeatsListExtension on List<SeatModel> {
  int totalPrice() => map((model) => model.price).reduce((a, b) => a + b);
}