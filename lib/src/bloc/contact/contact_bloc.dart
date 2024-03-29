


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/contact/contact_event.dart';
import 'package:wellbeing/src/bloc/contact/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState()) {
    // Fetch
  on<ContactEventFetch>((event, emit) async {
      emit(state.copywith(status: FetchStatusContact.success, contact: []));
      emit(state.copywith(status: FetchStatusContact.fetching));
      await Future.delayed(Duration(milliseconds: 300));
      final contact = await NetworkService().getContact(event.payload);
      emit(state.copywith(status: FetchStatusContact.success, contact: contact));
    });
  }
}