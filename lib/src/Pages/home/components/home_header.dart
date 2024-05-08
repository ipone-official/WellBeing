import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wellbeing/src/Pages/models/users.dart';
import 'package:wellbeing/src/bloc/User/user_bloc.dart';
import 'package:wellbeing/src/bloc/user/user_event.dart';
import 'package:wellbeing/src/bloc/user/user_state.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? employeeId;
  String? fullName;
  var items = <Users>[];
  @override
  void initState() {
    getStorage();
    super.initState();
  }

  void getStorage() async {
    final prefs = await SharedPreferences.getInstance();
    employeeId = prefs.getString(NetworkAPI.token);
    // final storage = FlutterSecureStorage();
    // fullName = await storage.read(key: fullName);
    setState(() {});
    print("employeeId");
    print(employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.040,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${employeeId}",
                        // 'Mr. Piyapong Sablabloy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.050),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.040,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'รหัสพนักงาน ${fullName}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.030),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
  Widget _buildContentHeader(List<Users> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          
        });
  }
}
