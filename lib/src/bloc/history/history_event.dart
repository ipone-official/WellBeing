import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}
class HistoryEventFetch extends HistoryEvent {
   final payload;
  HistoryEventFetch(this.payload);
}
