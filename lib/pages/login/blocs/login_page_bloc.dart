import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/utils/eventbus.dart';
import 'package:yes_play_music/utils/global.dart';

sealed class LoginFormChangeEvent {}

class QRCodeLoginAction extends LoginFormChangeEvent {}

class EmailLoginAction extends LoginFormChangeEvent {}

class PhoneNumberLoginAction extends LoginFormChangeEvent {}

@immutable
sealed class LoginFormState extends Equatable {
  get title;
}

class QRCodeFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
  @override
  get title => '二维码登录';
}

class EmailFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
  @override
  get title => '邮箱登录';
}

class PhoneNumberFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
  @override
  get title => '手机登录';
}

class LoginFormBloc extends Bloc<LoginFormChangeEvent, LoginFormState> {
  LoginFormBloc() : super(QRCodeFormState()) {
    on<QRCodeLoginAction>((event, emit) => emit(QRCodeFormState()));
    on<PhoneNumberLoginAction>((event, emit) {
      //事件总线关闭二维码状态轮询
      CommonEventBus.instance.fire(const QRCodeLoginPageClosedEvent());
      emit(PhoneNumberFormState());
    });
    on<EmailLoginAction>((event, emit) {
      CommonEventBus.instance.fire(const QRCodeLoginPageClosedEvent());
      emit(EmailFormState());
    });
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    logger.e(error);
    super.onError(error, stackTrace);
  }
}
