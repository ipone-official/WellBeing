import 'package:equatable/equatable.dart';
import 'package:wellbeing/src/Pages/models/UserAd.dart';

enum LoginStatus { fetching, success, failed, init }

class AuthState extends Equatable {
  final List<UserAd> userAd;
  final LoginStatus status;
  // final String dialogMessage;

  const AuthState({
    this.userAd = const [],
    this.status = LoginStatus.init,
    // this.dialogMessage = "",
  });

  AuthState copyWith({
    List<UserAd>? userAd,
    LoginStatus? status,
    String? dialogMessage,
  }) {
    return AuthState(
      userAd: userAd ?? this.userAd,
      status: status ?? this.status,
      // dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [userAd, status, ];
}