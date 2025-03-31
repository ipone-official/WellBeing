import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellbeing/src/Pages/login/login_page.dart';
import 'package:wellbeing/src/bloc/User/user_bloc.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/bloc/contact/contact_bloc.dart';
import 'package:wellbeing/src/bloc/history/history_bloc.dart';
import 'package:wellbeing/src/bloc/me_recode/record_me_bloc.dart';
import 'package:wellbeing/src/bloc/record/record_bloc.dart';
import 'package:wellbeing/src/bloc/record_runner/record_runner_bloc.dart';
import 'package:wellbeing/src/bloc/user/user_cubit.dart';
import 'package:wellbeing/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/app_routes.dart';
import 'Pages/home/home_page.dart';
import 'constants/network_api.dart';
import 'package:logger/logger.dart';

final navigatorState = GlobalKey<NavigatorState>();

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
  ),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// kReleaseMode เป็นการเช็คว่ามีการ build ขึ้น production ไหม ถ้าขึ้น nothing คือไม่แสดง Logger
    Logger.level = kReleaseMode ? Level.nothing : Level.debug;
    final authBloc = BlocProvider<AuthBloc>(create: (context) => AuthBloc());
    final recordBloc =
        BlocProvider<RecordBloc>(create: (context) => RecordBloc());
    final historyBloc =
        BlocProvider<HistoryBloc>(create: (context) => HistoryBloc());
    final recordRunnerBloc =
        BlocProvider<RecordRunnerBloc>(create: (context) => RecordRunnerBloc());
            final usersBloc =
        BlocProvider<UserBloc>(create: (context) => UserBloc());
  final recordMeBloc =
        BlocProvider<RecordMeBloc>(create: (context) => RecordMeBloc());
          final contactBloc =
        BlocProvider<ContactBloc>(create: (context) => ContactBloc());

    return MultiBlocProvider(
      providers: [
        authBloc,
        recordBloc,
        historyBloc,
        recordRunnerBloc,
        usersBloc,
        recordMeBloc,
        contactBloc,
         BlocProvider(create: (_) => UserCubit()),
      ],
      child: MaterialApp(
        title: "I.P. ONE HAPPY CLUB",
        routes: AppRoute.all,
        theme: theme(),
        home: _buildInitialPage(),
        navigatorKey: navigatorState,
      ),
    );
  }

  _buildInitialPage() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        }
        final prefs = snapshot.data!;
        final token = prefs.getString(NetworkAPI.token);
        return token == null ? LoginPage() : HomePage();
        //  return token == null ? HomePage() : HomePage();
      },
    );
  }
}
