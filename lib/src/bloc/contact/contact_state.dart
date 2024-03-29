
import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/contact.dart';

enum FetchStatusContact { fetching, success, failed, init }

class ContactState extends Equatable {
  const ContactState({
    this.contact = const [],
    this.status = FetchStatusContact.init
  });

  final List<Contact> contact;
  final FetchStatusContact status;

  ContactState copywith(
      {List<Contact>? contact, FetchStatusContact? status}) {
    return ContactState(
        contact: contact ?? this.contact,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [contact, status,];
}
