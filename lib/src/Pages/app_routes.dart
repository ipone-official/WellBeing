import 'package:flutter/material.dart';
import 'Runner/history/contact_page.dart';
import 'Runner/history/history_page.dart';
import 'Runner/record_page.dart';
import 'home/home_page.dart';
import 'loading/loading_page.dart';
import 'login/login_page.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const record = 'record';
  static const loading = 'loading';
  static const history = 'history';
  static const contact = 'contact';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(),
        home: (context) => const HomePage(),
        record: (context) => const RecordPage(),
        loading: (context) => const LoadingPage(),
        history: (context) => const HistoryPage(),
        contact: (context) => const ContactPage(),
      };
}
