import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/user_class.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// Login Event
class AuthEventLogin extends AuthEvent {
   final User payload;
  AuthEventLogin(this.payload);
}

// Logout Event
class AuthEventLogout extends AuthEvent {}