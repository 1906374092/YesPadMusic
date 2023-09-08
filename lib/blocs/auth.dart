import 'package:bloc/bloc.dart';

sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  String cookie;
  LoginEvent(this.cookie);
}

final class LogoutEvent extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>((event, emit) => state.cookie = event.cookie);
  }
}

class AuthState {
  String cookie = '';
}
