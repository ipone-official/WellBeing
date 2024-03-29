import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/models/user_class.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_flushbar.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEventLogin>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.fetching));
      // await Future.delayed(Duration(milliseconds: 1000));
      final String userId = event.payload.username;
      final String password = event.payload.password;
      String result;
      result = await NetworkService().Login(userId, password);
      // if (username == 'admin' && password == '1234') {
      //   final prefs = await SharedPreferences.getInstance();
      //   prefs.setString(NetworkAPI.token, "12341241243134134");
      //   prefs.setString(NetworkAPI.username, username);
      //   emit(state.copyWith(status: LoginStatus.success));
      if (result == '200') {
        emit(state.copyWith(status: LoginStatus.success));
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(NetworkAPI.token, userId);
        // prefs.setString(NetworkAPI.username, username);
      } else {
        emit(state.copyWith(
            status: LoginStatus.failed,
            dialogMessage: "Invalid Username or Password!"));
      }
      //  CustomFlushbar.showSuccess(navigatorState.currentContext!,
      //       message: result);
    });
    // Logout
    on<AuthEventLogout>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(state.copyWith(status: LoginStatus.init));

      Navigator.pushReplacementNamed(
          navigatorState.currentContext!, AppRoute.login);
    });
  }
}
