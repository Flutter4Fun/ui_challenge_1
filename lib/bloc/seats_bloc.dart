import 'dart:async';

import 'package:equatable/equatable.dart';

import 'bloc.dart';

class SeatsBloc extends BlocBase {
  late StreamController<MapEntry<SeatModel, int>> _onItemAdded;
  late StreamController<MapEntry<SeatModel, int>> _onItemRemoved;
  late StreamController<List<MapEntry<SeatModel, int>>> _onItemsCleared;
  late StreamController<List<SeatModel>> _onAnythingChanged;

  List<SeatModel> _selectedSeats = [];
  late List<List<SeatModel>> _allSeats;

  SeatsBloc() {
    _onItemAdded = StreamController.broadcast();
    _onItemRemoved = StreamController.broadcast();
    _onItemsCleared = StreamController.broadcast();
    _onAnythingChanged = StreamController.broadcast();
    _allSeats = getInitialSeats();
  }

  void addItem(SeatModel seatModel) {
    if (_selectedSeats.contains(seatModel)) {
      throw ArgumentError("seatModel is exists in the list");
    }
    if (seatModel.state != SeatState.Available) {
      throw ArgumentError("seatModel is is not available");
    }

    _selectedSeats.add(seatModel);
    _onItemAdded.sink.add(MapEntry(seatModel, _selectedSeats.length - 1));
    _allSeats[seatModel.row][seatModel.column] =
        _allSeats[seatModel.row][seatModel.column].copyWith(state: SeatState.Selected);
    _onAnythingChanged.sink.add(_selectedSeats);
  }

  void removeItem(SeatModel seatModel) {
    if (!_selectedSeats.contains(seatModel)) {
      throw ArgumentError("seatModel is not exists in the list");
    }
    if (seatModel.state != SeatState.Selected) {
      throw ArgumentError("seatModel is is not selected");
    }

    final index = _selectedSeats.indexOf(seatModel);
    _selectedSeats.remove(seatModel);
    _onItemRemoved.sink.add(MapEntry(seatModel, index));
    _allSeats[seatModel.row][seatModel.column] =
        _allSeats[seatModel.row][seatModel.column].copyWith(state: SeatState.Available);
    _onAnythingChanged.sink.add(_selectedSeats);
  }

  void clearAllItems() {
    List<MapEntry<SeatModel, int>> clearedItems = _selectedSeats.asMap().map((index, model) => MapEntry(model, index)).entries.toList();
    _selectedSeats.clear();
    _allSeats = getInitialSeats();
    _onItemsCleared.sink.add(clearedItems);
    _onAnythingChanged.sink.add(_selectedSeats);
  }

  Stream<MapEntry<SeatModel, int>> onItemAdded() => _onItemAdded.stream;

  Stream<MapEntry<SeatModel, int>> onItemRemoved() => _onItemRemoved.stream;

  Stream<List<MapEntry<SeatModel, int>>> onItemsCleared() => _onItemsCleared.stream;

  Stream<List<SeatModel>> onAnythingChanged() => _onAnythingChanged.stream;

  List<SeatModel> getSelectedItems() => List.of(_selectedSeats);

  List<List<SeatModel>> getAllSeatsState() => List.of(_allSeats);

  List<List<SeatModel>> getInitialSeats() {
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
                default: throw StateError('invalid state');
              }
              return state;
            }).toList())
        .toList();

    return List.generate(states.length, (row) {
       return List.generate(states[row].length, (col) {
         return SeatModel(states[row][col], row, col, 60);
       });
    });
  }

  @override
  void dispose() {
    _onItemAdded.close();
    _onItemRemoved.close();
    _onItemsCleared.close();
    _onAnythingChanged.close();
  }
}

enum SeatState {
  Available,
  Selected,
  Reserved,
  None,
}

class SeatModel extends Equatable {
  final SeatState state;
  final int row, column;
  final int price;

  SeatModel(
    this.state,
    this.row,
    this.column,
    this.price,
  );

  SeatModel copyWith({
    SeatState? state,
    int? row,
    int? column,
    int? price,
  }) {
    return SeatModel(
      state ?? this.state,
      row ?? this.row,
      column ?? this.column,
      price ?? this.price,
    );
  }

  @override
  List<Object> get props => [
        row,
        column,
        price,
      ];
}
