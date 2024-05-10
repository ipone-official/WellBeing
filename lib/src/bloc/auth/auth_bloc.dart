import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/bloc/auth/auth_event.dart';
import 'package:wellbeing/src/bloc/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEventLogin>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.success, userAd: []));
      emit(state.copyWith(status: LoginStatus.fetching));
      // await Future.delayed(Duration(milliseconds: 1000));
      final String userId = event.payload.username;
      final String password = event.payload.password;
      final userAd = await NetworkService().Login(userId, password);
      if(userAd[0].authentication){
          emit(state.copyWith(status: LoginStatus.success, userAd: userAd));
      } else {
         emit(state.copyWith(status: LoginStatus.failed, userAd: userAd));
      }
      
     
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
