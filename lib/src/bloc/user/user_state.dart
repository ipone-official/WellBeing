
import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/users.dart';

enum FetchStatusUser { fetching, success, failed, init }

class UserState extends Equatable {
  const UserState({
    this.users = const [],
    this.status = FetchStatusUser.init
  });

  final List<Users> users;
  final FetchStatusUser status;

  UserState copywith(
      {List<Users>? users, FetchStatusUser? status}) {
    return UserState(
        users: users ?? this.users,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [users, status,];
}
