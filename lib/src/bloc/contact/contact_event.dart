import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}
class ContactEventFetch extends ContactEvent {
   final payload;
  ContactEventFetch(this.payload);
}
