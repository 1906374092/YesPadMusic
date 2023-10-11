import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  String cookie;
  LoginEvent(this.cookie);
}

final class LogoutEvent extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LogoutState());
}

@immutable
sealed class AuthState {}

class LoginState extends AuthState {}

class LogoutState extends AuthState {}
