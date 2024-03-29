


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/history/history_event.dart';
import 'package:wellbeing/src/bloc/history/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState()) {
    // Fetch
  on<HistoryEventFetch>((event, emit) async {
      emit(state.copywith(status: FetchStatusHistory.success, history: []));
      emit(state.copywith(status: FetchStatusHistory.fetching));
      await Future.delayed(Duration(milliseconds: 300));
      final history= await NetworkService().getHistory(event.payload);
      emit(state.copywith(status: FetchStatusHistory.success, history: history));
    });
  }
}