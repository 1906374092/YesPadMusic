import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yes_play_music/pages/user/data/user_repository.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';
import 'package:yes_play_music/utils/database.dart';
import 'package:yes_play_music/utils/global.dart';

sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  // String cookie;
  // LoginEvent(this.cookie);
}

final class LogoutEvent extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository repository;
  AuthBloc({required this.repository}) : super(LogoutState()) {
    on<LoginEvent>((event, emit) async {
      try {
        String? cookie = await CookieBase.getCookie();
        if (cookie == null || cookie == '') return;
        UserModel user = await repository.getUserAccount();
        emit(LoginState(user: user));
      } catch (e) {
        add(LogoutEvent());
        logger.e(e);
      }
    });
    on<LogoutEvent>((event, emit) {
      HapticFeedback.lightImpact();
      CookieBase.removeCookie();
      emit(LogoutState());
    });
  }
}

@immutable
sealed class AuthState extends Equatable {}

class LoginState extends AuthState {
  final UserModel user;
  LoginState({required this.user});

  @override
  List<Object?> get props => [user];
}

class LogoutState extends AuthState {
  @override
  List<Object?> get props => [];
}
