import 'package:equatable/equatable.dart';

abstract class RecordEvent extends Equatable {
  const RecordEvent();

  @override
  List<Object?> get props => [];
}

// Fetch Event
class RecordEventFetch extends RecordEvent {}


