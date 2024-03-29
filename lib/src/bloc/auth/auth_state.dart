part of 'auth_bloc.dart';

enum LoginStatus { fetching, success, failed, init }

class AuthState extends Equatable {
  final LoginStatus status;
  final String dialogMessage;

  const AuthState({
    this.status = LoginStatus.init,
    this.dialogMessage = "",
  });

  AuthState copyWith({
    LoginStatus? status,
    String? dialogMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [status, dialogMessage];
}