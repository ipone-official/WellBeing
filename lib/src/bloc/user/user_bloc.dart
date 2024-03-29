


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/user/user_event.dart';
import 'package:wellbeing/src/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    // Fetch
  on<UserEventFetch>((event, emit) async {
      emit(state.copywith(status: FetchStatusUser.success, users: []));
      emit(state.copywith(status: FetchStatusUser.fetching));
      await Future.delayed(Duration(milliseconds: 300));
      final users= await NetworkService().getUser(event.payload);
      emit(state.copywith(status: FetchStatusUser.success, users: users));
    });
  }
}