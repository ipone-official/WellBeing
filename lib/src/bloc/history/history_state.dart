
import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/history_runner.dart';

enum FetchStatusHistory { fetching, success, failed, init }

class HistoryState extends Equatable {
  const HistoryState({
    this.history = const [],
    this.status = FetchStatusHistory.init
  });

  final List<HistoryRunner> history;
  final FetchStatusHistory status;

  HistoryState copywith(
      {List<HistoryRunner>? history, FetchStatusHistory? status}) {
    return HistoryState(
        history: history ?? this.history,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [history, status,];
}
