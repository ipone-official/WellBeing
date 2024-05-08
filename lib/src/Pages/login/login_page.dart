import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/models/UserAd.dart';
import 'package:wellbeing/src/Pages/models/user_class.dart';
import 'package:wellbeing/src/Pages/provider/loginAd_provider.dart';
import 'package:wellbeing/src/Pages/services/constants.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/constants/asset.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:wellbeing/src/widgets/custom_flushbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 127, 196, 100),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.11),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                  size: Size.fromRadius(MediaQuery.of(context).size.height *
                      0.13), // Image radius
                  child: Image.asset(Asset.LogoAppImage)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildLogin()],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildLogin() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
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
            height: MediaQuery.of(context).size.height * 0.28,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Username
                  TextField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-z .]')),
                    ],
                    maxLength: 20,
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'ชื่อจริง(.)นามสกุลตัวแรก',
                      labelText: 'ชื่อผู้ใช้',
                      icon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  TextField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[A-Za-z/./@!%*?&^#\$+-/=/0-9]')),
                    ],
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
                  ElevatedButton(
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
                    onPressed: () {
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
                      authenUser(
                        username,
                        password,
                      );
                    },
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: MediaQuery.of(context).size.height * 0.019),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.26,
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
    );
  }

  void authenUser(String userid, String password) {
    loginAdProvider().getUser(userid, password).then((value) async {
      UserAd _userAd = value;
      if (_userAd.authentication) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(NetworkAPI.token, _userAd.empId);
        // final storage = FlutterSecureStorage();
        // storage.write(key: fullName, value: _userAd.name);
        // var fullNames = await storage.read(key: fullName);
        // print(fullNames);
        Navigator.pushReplacementNamed(context, AppRoute.home);
      } else {
        _showAlert("ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง!", context, "error");
      }
    }).catchError((e) {
      _showAlert("ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง!", context, "error");
    });
  }

  void _showAlert(String dialogMessage, BuildContext context, String TxtIcon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              dialogMessage,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035),
            ),
          ),
          content: TxtIcon == "error"
              ? SizedBox()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: Color.fromRGBO(
                        0,
                        127,
                        196,
                        1,
                      ),
                      rightDotColor: Color.fromRGBO(248, 200, 73, 1),
                      size: 80,
                    ),
                  ),
                ),
          icon: TxtIcon == "error"
              ? const Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                )
              : SizedBox(),
          actions: [
            TxtIcon == "error"
                ? ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ปิด"),
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
