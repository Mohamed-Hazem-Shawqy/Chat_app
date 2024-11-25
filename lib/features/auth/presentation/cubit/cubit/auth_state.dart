part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SigninLoading extends AuthState {}

class SigninSuccess extends AuthState {}

class SigninFailuer extends AuthState {
  final String errMessage;

  SigninFailuer({required this.errMessage});
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailuer extends AuthState {
  final String errMessage;

  SignUpFailuer({required this.errMessage});
}

class GoogleSigninLoading extends AuthState {}

class GoogleSigninSuccess extends AuthState {}

class GoogleSigninFailuer extends AuthState {
  final String errMessage;

  GoogleSigninFailuer({required this.errMessage});
}
