import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellbeing/src/Pages/services/network_service.dart';
import 'package:wellbeing/src/bloc/user/user_cubit.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:wellbeing/src/Pages/models/users.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _hasTriedFetch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tryFetchUser();
  }

  Future<void> _tryFetchUser() async {
    if (_hasTriedFetch) return; // ไม่โหลดซ้ำ
    _hasTriedFetch = true;

    final user = context.read<UserCubit>().state;
    if (user != null) return;

    final prefs = await SharedPreferences.getInstance();
    final empId = prefs.getString(NetworkAPI.token);

    if (empId != null) {
      print("➡️ GET USER BY ID: $empId");
      final users = await NetworkService().getUser(empId);
      print("👥 USERS DATA: ${users.map((e) => e.toJson())}");

      if (users.isNotEmpty) {
        final user = users.first;
        print("✅ SET USER: ${user.employeeNameTh}");
        context.read<UserCubit>().setUser(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, Users?>(
      builder: (context, user) {
        if (user == null) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "ไม่พบข้อมูลผู้ใช้งาน",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.employeeNameTh,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.050,
                  ),
                ),
                Text(
                  'รหัสพนักงาน ${user.employeeId}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.030,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
