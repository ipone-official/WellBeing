import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/record/record_event.dart';
import 'package:wellbeing/src/bloc/record/record_state.dart';


class RecordBloc extends Bloc<RecordEvent, RecordState> {
  RecordBloc() : super(RecordState()) {
    // Fetch top 5
    on<RecordEventFetch>((event, emit) async {
      emit(state.copywith(status: FetchStatus.success, rankRunner: []));
      emit(state.copywith(status: FetchStatus.fetching));
      await Future.delayed(Duration(milliseconds: 300));
      final rankRunner = await NetworkService().getRankRunner();
      emit(state.copywith(status: FetchStatus.success, rankRunner: rankRunner));
    });

  }
}