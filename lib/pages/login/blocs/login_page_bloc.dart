import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/login/data/login_repository.dart';

sealed class LoginFormChangeEvent {}

class QRCodeLoginAction extends LoginFormChangeEvent {}

class EmailLoginAction extends LoginFormChangeEvent {}

class PhoneNumberLoginAction extends LoginFormChangeEvent {}

@immutable
sealed class LoginFormState {}

class QRCodeFormState extends LoginFormState {
  final Uint8List? qrcodeData;
  final String? message;
  QRCodeFormState({this.qrcodeData, this.message = '打开网易云音乐APP扫码登录'});
}

class EmailFormState extends LoginFormState {}

class PhoneNumberFormState extends LoginFormState {}

class LoginFormBloc extends Bloc<LoginFormChangeEvent, LoginFormState> {
  final LoginRepository repository;
  LoginFormBloc({required this.repository}) : super(QRCodeFormState()) {
    on<QRCodeLoginAction>((event, emit) async {
      Uint8List qrdata = await repository.getQRCodeString();
      emit(QRCodeFormState(qrcodeData: qrdata));

      //轮询登录状态
      Timer.periodic(const Duration(milliseconds: 500), (timer) async {
        num code = await repository.checkLoginStatus();
        switch (code) {
          case 800:
            //二维码过期
            break;
          case 801:
            //等待扫码
            break;
          case 802:
            //待确认
            break;
          case 803:
            //登录成功
            timer.cancel();
            break;
          default:
        }
      });
    });
  }
}
