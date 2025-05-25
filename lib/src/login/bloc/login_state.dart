part of 'login_bloc.dart';

enum LoginStatus { initial, loading, loggedIn, loggedOut, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final UsersModel user;
  final LoginStatus status;
  final LoginStatus savedStatus;
  final String message;
  final String systemTheme;
  final Map<String, dynamic> themeJson;

  const LoginState({
    required this.email,
    required this.password,
    required this.user,
    required this.status,
    required this.savedStatus,
    required this.message,
    required this.systemTheme,
    required this.themeJson,
  });

  static final LoginState initial = LoginState(
    email: "",
    password: "",
    user: UsersModel.empty(),
    status: LoginStatus.initial,
    savedStatus: LoginStatus.initial,
    message: "",
    systemTheme: "",
    themeJson: {},
  );

  LoginState copyWith({
    String Function()? email,
    String Function()? password,
    UsersModel Function()? user,
    LoginStatus Function()? status,
    LoginStatus Function()? savedStatus,
    String Function()? message,
    String Function()? systemTheme,
    Map<String, dynamic> Function()? themeJson,
  }) {
    return LoginState(
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
      user: user != null ? user() : this.user,
      status: status != null ? status() : this.status,
      savedStatus: savedStatus != null ? savedStatus() : this.savedStatus,
      message: message != null ? message() : this.message,
      systemTheme: systemTheme != null ? systemTheme() : this.systemTheme,
      themeJson: themeJson != null ? themeJson() : this.themeJson,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    user,
    status,
    savedStatus,
    message,
    systemTheme,
    themeJson,
  ];
}
