import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class RecordRunnerEvent extends Equatable {
  const RecordRunnerEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RecordRunnerEventSubmit extends RecordRunnerEvent {

  final String? employeeId;
  final String? record;
  final String? image;

  const RecordRunnerEventSubmit({
    this.employeeId,
    this.record,
    this.image,
  });
}
