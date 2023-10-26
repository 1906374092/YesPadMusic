import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/login/data/email_login_repository.dart';
import 'package:yes_play_music/pages/login/models/login_model.dart';
import 'package:yes_play_music/utils/tools.dart';
import 'package:yes_play_music/utils/validator.dart';

sealed class EmailLoginState extends Equatable {}

class EmailLoginUnValidateState extends EmailLoginState {
  @override
  List<Object?> get props => [];
}

class EmailLoginValidateState extends EmailLoginState {
  @override
  List<Object?> get props => [];
}

class EmailLoginSuccessState extends EmailLoginState {
  @override
  List<Object?> get props => [];
}

@immutable
sealed class EmailLoginEvent {}

class ValidateEmailAction extends EmailLoginEvent {
  final String emailText;
  ValidateEmailAction({required this.emailText});
}

class ValidatePasswordAction extends EmailLoginEvent {
  final String password;
  ValidatePasswordAction({required this.password});
}

class SendEmailLoginRequestAction extends EmailLoginEvent {}

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  final EmailLoginRepository repository;
  bool emailCorrect = false;
  bool passwordCorrect = false;
  String email = '';
  String password = '';
  EmailLoginBloc({required this.repository})
      : super(EmailLoginUnValidateState()) {
    on<ValidateEmailAction>((event, emit) {
      email = event.emailText;
      emailCorrect = Validator.checkEmail(event.emailText);
      if (!emailCorrect) Tools.showToast('请输入正确的邮箱');
      if (emailCorrect && passwordCorrect) {
        emit(EmailLoginValidateState());
      } else {
        emit(EmailLoginUnValidateState());
      }
    });
    on<ValidatePasswordAction>((event, emit) {
      password = event.password;
      passwordCorrect = event.password.isNotEmpty;
      if (emailCorrect && passwordCorrect) {
        emit(EmailLoginValidateState());
      } else {
        emit(EmailLoginUnValidateState());
      }
    });
    on<SendEmailLoginRequestAction>((event, emit) async {
      LoginModel result = await repository.emailLoginRequest(
          email, Tools.generateMd5(password));
      if (result.code == 200) {}
    });
  }
}
