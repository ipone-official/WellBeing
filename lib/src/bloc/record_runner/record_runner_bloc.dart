import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner.state.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner_event.dart';
// import 'package:wellbeing/src/widgets/custom_flushbar.dart';

class RecordRunnerBloc extends Bloc<RecordRunnerEvent, RecordRunnerState> {
  RecordRunnerBloc() : super(RecordRunnerState()) {
    on<RecordRunnerEventSubmit>((event, emit) async {
      final _employeeId = event.employeeId!;
      final _record = event.record!;
      final _imageFile = event.image!;

      emit(state.copyWith(status: SubmitStatus.submitting));
      await Future.delayed(Duration(seconds: 3));
      try {
        String result;
        result = await NetworkService()
            .postRecordRunner(_employeeId, _record, _imageFile);
        if (result == '200') {
          emit(state.copyWith(
              status: SubmitStatus.success, dialogMessage: "บันทึกสำเร็จ"));
        }
      } catch (exception) {
        emit(state.copyWith(
            status: SubmitStatus.failed, dialogMessage: "บันทึกไม่สำเร็จ"));
      }
    });
  }
}
