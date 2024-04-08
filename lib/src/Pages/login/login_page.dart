import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/models/user_class.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/constants/asset.dart';
import 'package:wellbeing/src/widgets/custom_flushbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 127, 196, 100),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                  size: Size.fromRadius(MediaQuery.of(context).size.height *
                      0.13), // Image radius
                  child: Image.asset(Asset.LogoAppImage)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildLogin()],
                ),
              ),
            ),
            // Center(
            //   child: Column(
            //     children: [
            //       Text(
            //         "©2024 I.P.One Co., Ltd. All rights reserved.",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: MediaQuery.of(context).size.width * 0.030),
            //       )
            //     ],
            //   ),
            // )
          ],
        ));
  }

  Widget _buildLogin() {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status case LoginStatus.success) {
          Navigator.pushReplacementNamed(context, AppRoute.home);
        } else if (state.status case LoginStatus.failed) {
          _showAlert(state.dialogMessage, context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Username
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                       maxLength: 6,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'รหัสพนักงาน',
                        labelText: 'ชื่อผู้ใช้',
                        icon: Icon(Icons.account_circle),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextField(
                      maxLength: 20,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'รหัสผ่าน',
                        labelText: 'รหัสผ่าน',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    // Login button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(248, 200, 73, 20),
                            padding:
                                EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            shape: StadiumBorder(),
                            side: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(248, 200, 73, 100),
                            ),
                          ),
                          onPressed: state.status == LoginStatus.fetching
                              ? null
                              : () {
                                  final username = _usernameController.text;
                                  final password = _passwordController.text;
                                  if (username == '') {
                                    return CustomFlushbar.showWarning(
                                        navigatorState.currentContext!,
                                        message: 'กรุณากรอกชื่อผู้ใช้');
                                  } else if (password == '') {
                                    return CustomFlushbar.showWarning(
                                        navigatorState.currentContext!,
                                        message: 'กรุณากรอกรหัสผ่าน');
                                  }
                                  context.read<AuthBloc>().add(
                                      AuthEventLogin(User(username, password)));
                                },
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
             SizedBox(
                      height: MediaQuery.of(context).size.height * 0.19,
                    ),
            Center(
              child: Column(
                children: [
                  Text(
                    "©2024 I.P.One Co., Ltd. All rights reserved.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.030),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showAlert(String dialogMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            dialogMessage,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
          ),
          icon: const Icon(
            Icons.error,
            size: 28.0,
            color: Colors.red,
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ปิด"),
            ),
          ],
        );
      },
    );
  }
}
