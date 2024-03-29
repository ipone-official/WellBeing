import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/me_recode/record_me_event.dart';
import 'package:wellbeing/src/bloc/me_recode/record_me_state.dart';


class RecordMeBloc extends Bloc<RecordMeEvent, RecordMeState> {
  RecordMeBloc() : super(RecordMeState()) {
    // Fetch 
        on<MeRunnerEventFetch>((event, emit) async {
      emit(state.copywith(status: FetchRecordMeStatus.success, rankMeRunner: []));
      emit(state.copywith(status: FetchRecordMeStatus.fetching));
      await Future.delayed(Duration(milliseconds: 300));
      final rankMeRunner = await NetworkService().getMeRunner(event.payload);
      emit(state.copywith(status: FetchRecordMeStatus.success, rankMeRunner: rankMeRunner));
    });
  }
}