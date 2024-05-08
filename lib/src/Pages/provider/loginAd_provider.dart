import 'package:wellbeing/src/Pages/models/UserAd.dart';
import 'package:wellbeing/src/Pages/services/loginAd_api.dart';

class loginAdProvider {
  LoginAdApi api = LoginAdApi();

    Future<UserAd> getUser(userId, password) async {
    return api.fUserAd(userId, password);
  }
}