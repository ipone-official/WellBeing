import 'package:equatable/equatable.dart';

enum SubmitStatus { submitting, success, failed, init }

class RecordRunnerState extends Equatable {
  final SubmitStatus status;
  final String dialogMessage;

  const RecordRunnerState({this.status = SubmitStatus.init,
  this.dialogMessage = "",});

  RecordRunnerState copyWith({
    SubmitStatus? status,
    String? dialogMessage,
  }) {
    return RecordRunnerState(
      status: status ?? this.status,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [status, dialogMessage];
}
