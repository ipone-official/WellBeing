import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/Pages/models/user_class.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/widgets/custom_flushbar.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  // this.defaultUsername, this.defaultPassword,
  // String? defaultUsername;
  // String? defaultPassword;
  final TextEditingController _usernameController = TextEditingController();
 final TextEditingController  _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // _usernameController.text = defaultUsername ?? "";
    // _passwordController.text = defaultPassword ?? "";

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
        child: Container(
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
                  keyboardType: TextInputType.number,
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'รหัสพนักงาน',
                    labelText: 'ชื่อผู้ใช้',
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
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
                              //           if(username == ''){
                              //                return CustomFlushbar.showWarning(navigatorState.currentContext!,
                              // message: 'กรอกชื่อผู้ใช้');
                              //           }
                              context.read<AuthBloc>().add(
                                  AuthEventLogin(User(username, password)));
                            },
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlert(String dialogMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogMessage),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
