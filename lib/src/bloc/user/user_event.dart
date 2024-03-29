import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}
class UserEventFetch extends UserEvent {
   final payload;
  UserEventFetch(this.payload);
}
