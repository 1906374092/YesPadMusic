import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yes_play_music/pages/login/data/qr_login_repository.dart';
import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/pages/login/models/login_model.dart';
import 'package:yes_play_music/utils/eventbus.dart';

sealed class QRCodeEvent {}

class GetQRCodeDataEvent extends QRCodeEvent {}

class WaitForConfirmLoginEvent extends QRCodeEvent {}

class SuccessLoginEvent extends QRCodeEvent {}

@immutable
sealed class QRCodeState extends Equatable {}

class LoadingQRCodeState extends QRCodeState {
  @override
  List<Object?> get props => [];
}

class GotQRCodeState extends QRCodeState {
  final String? qrUrl;
  final String? message;
  final bool? showCodeCover;
  GotQRCodeState({
    this.qrUrl,
    this.message = '打开网易云音乐APP扫码登录',
    this.showCodeCover = false,
  });

  @override
  List<Object?> get props => [qrUrl, message];
}

class SuccessLoginState extends QRCodeState {
  @override
  List<Object?> get props => [];
}

class ErrorQRCodeState extends QRCodeState {
  @override
  List<Object?> get props => [];
}

class QRCodeLoginBloc extends Bloc<QRCodeEvent, QRCodeState> {
  final QRCodeLoginRepository repository;
  late Timer checkQRScanStatusTimer;
  QRCodeLoginBloc({required this.repository}) : super(LoadingQRCodeState()) {
    String qrUrl = '';
    on<GetQRCodeDataEvent>((event, emit) async {
      qrUrl = await repository.getQRCodeString();
      emit(GotQRCodeState(qrUrl: qrUrl));

      //轮询登录状态
      checkQRScanStatusTimer =
          Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
        LoginModel result = await repository.checkLoginStatus();
        switch (result.code) {
          case 800:
            //二维码过期
            timer.cancel();

            break;
          case 801:
            //等待扫码
            break;
          case 802:
            //待确认
            add(WaitForConfirmLoginEvent());
            break;
          case 803:
            //登录成功
            add(SuccessLoginEvent());
            timer.cancel();

            break;
          default:
            timer.cancel();
        }
      });
      CommonEventBus.instance.listen<QRCodeLoginPageClosedEvent>((event) {
        checkQRScanStatusTimer.cancel();
      });
    });
    on<WaitForConfirmLoginEvent>((event, emit) =>
        emit(GotQRCodeState(qrUrl: qrUrl, message: '扫描成功，请在手机上确认登录')));
    on<SuccessLoginEvent>((event, emit) => emit(SuccessLoginState()));
  }
}
