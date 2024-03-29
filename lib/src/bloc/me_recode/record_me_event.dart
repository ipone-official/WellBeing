import 'package:equatable/equatable.dart';

abstract class RecordMeEvent extends Equatable {
  const RecordMeEvent();

  @override
  List<Object?> get props => [];
}

// Fetch Event
class MeRunnerEventFetch extends RecordMeEvent {
   final payload;
     MeRunnerEventFetch(this.payload);
}
