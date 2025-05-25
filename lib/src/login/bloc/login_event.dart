part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginEvent {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends LoginEvent {}

class ChangeUserPreferenceValue extends LoginEvent {
  final Map<String, dynamic> formData;

  const ChangeUserPreferenceValue({required this.formData});

  @override
  List<Object> get props => [formData];
}

class SubmitUserPreference extends LoginEvent {}

class ChangeThemeMode extends LoginEvent {
  final bool? isSystemTheme;
  final String themeMode;

  const ChangeThemeMode({this.isSystemTheme, required this.themeMode});

  @override
  List<Object?> get props => [isSystemTheme, themeMode];
}
