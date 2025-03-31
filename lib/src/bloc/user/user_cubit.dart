import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/users.dart';

class UserCubit extends Cubit<Users?> {
  UserCubit() : super(null);

  void setUser(Users user) => emit(user);

  void clearUser() => emit(null);
}
