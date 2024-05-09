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
  var items = <Users>[];
  @override
  void initState() {
    getStorage();
    super.initState();
  }

  void getStorage() async {
    final prefs = await SharedPreferences.getInstance();
    employeeId = prefs.getString(NetworkAPI.token);
    context.read<UserBloc>().add(UserEventFetch(employeeId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        items = state.users;
        return Container(
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: _buildContentHeader(items),
                  );
        // RefreshIndicator(
        //     onRefresh: () async =>
        //         context.read<UserBloc>().add(UserEventFetch(employeeId)),
        //     child: state.status == FetchStatusUser.fetching
        //         ?  Container(
        //                   alignment: Alignment.center,
        //                   height: MediaQuery.of(context).size.width * 0.13,
        //                   child: _loading())
        //         : Container(
        //             height: MediaQuery.of(context).size.width * 0.13,
        //             child: _buildContentHeader(items),
        //           )
        //           );
      },
    ));
  }
  Widget _loading() {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: Color.fromRGBO(
          0,
          127,
          196,
          1,
        ),
        rightDotColor: Color.fromRGBO(248, 200, 73, 1),
        size: 50,
      ),
    );
  }

  Widget _buildContentHeader(List<Users> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
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
                        "${users[index].employeeNameTh}",
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
                        'รหัสพนักงาน ${users[index].employeeId}',
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
        });
  }
}
