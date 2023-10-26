import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yes_play_music/pages/login/data/phone_login_repostory.dart';
import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/pages/login/models/sms_model.dart';
import 'package:yes_play_music/utils/eventbus.dart';
import 'package:yes_play_music/utils/validator.dart';

sealed class PhoneLoginState extends Equatable {
  final bool phoneNumValidate;
  final String phoneNum;
  final int? count;
  const PhoneLoginState(
      {required this.phoneNumValidate,
      required this.phoneNum,
      this.count = 60});
}

class InputPhoneNumState extends PhoneLoginState {
  const InputPhoneNumState(
      {required super.phoneNumValidate, required super.phoneNum, super.count});

  @override
  List<Object?> get props => [phoneNumValidate, phoneNum, count];
}

class InputSMSCodeState extends PhoneLoginState {
  const InputSMSCodeState(
      {required super.phoneNumValidate, required super.phoneNum, super.count});
  @override
  List<Object?> get props => [phoneNumValidate, phoneNum, count];
}

class PhoneLoginSuccessState extends PhoneLoginState {
  const PhoneLoginSuccessState(
      {required super.phoneNumValidate, required super.phoneNum, super.count});
  @override
  List<Object?> get props => [phoneNumValidate, phoneNum, count];
}

@immutable
sealed class PhoneLoginEvent {}

class GoToSMSEvent extends PhoneLoginEvent {}

class GoToPhoneNumEvent extends PhoneLoginEvent {}

class PhoneNumChangedEvent extends PhoneLoginEvent {
  final String phoneText;
  PhoneNumChangedEvent({required this.phoneText});
}

class _TimerCountEvent extends PhoneLoginEvent {}

class LoginRequestEvent extends PhoneLoginEvent {
  final String smsCode;
  LoginRequestEvent({required this.smsCode});
}

class PhoneLoginBloc extends Bloc<PhoneLoginEvent, PhoneLoginState> {
  final PhoneLoginRepository repository;
  String phoneNum = '';
  String smsCode = '';
  late Timer _timer;
  int count = 60;
  PhoneLoginBloc({required this.repository})
      : super(const InputPhoneNumState(phoneNumValidate: false, phoneNum: '')) {
    CommonEventBus.instance.listen<PhoneLoginPageCloseEvent>((event) {
      _timer.cancel();
    });
    on<GoToPhoneNumEvent>((event, emit) => emit(InputPhoneNumState(
        phoneNumValidate: state.phoneNumValidate, phoneNum: phoneNum)));
    on<GoToSMSEvent>((event, emit) async {
      if (!Validator.checkPhone(phoneNum)) {
        EasyLoading.showToast('手机格式不正确，请重试');
        return;
      }

      SMSSentModel model = await repository.sentSMSCodeRequest(phoneNum);
      if (model.code == 200) {
        EasyLoading.showToast('验证码已发送');
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          add(_TimerCountEvent());
        });
      } else {
        EasyLoading.showToast('验证码发送失败');
      }
    });
    on<PhoneNumChangedEvent>((event, emit) {
      phoneNum = event.phoneText;
      if (event.phoneText.isEmpty) {
        emit(InputPhoneNumState(phoneNumValidate: false, phoneNum: phoneNum));
      } else {
        emit(InputPhoneNumState(phoneNumValidate: true, phoneNum: phoneNum));
      }
    });
    on<_TimerCountEvent>((event, emit) {
      count--;
      emit(InputSMSCodeState(
          phoneNumValidate: state.phoneNumValidate,
          phoneNum: phoneNum,
          count: count));
      if (count == 0) {
        _timer.cancel();
        count = 60;
      }
    });
    //验证短信验证码，调用登录接口
    on<LoginRequestEvent>((event, emit) async {
      SMSSentModel validateResult =
          await repository.validateSMSCodeRequest(phoneNum, event.smsCode);
      if (validateResult.code != 200) {
        EasyLoading.showToast('验证码错误，请稍后再试');
        return;
      }
      SMSSentModel loginResult =
          await repository.loginWithSMSCodeRequest(phoneNum, event.smsCode);
      if (loginResult.code == 200) {
        EasyLoading.showToast('登录成功');
        emit(
            PhoneLoginSuccessState(phoneNumValidate: true, phoneNum: phoneNum));
      } else {
        EasyLoading.showToast(loginResult.message);
      }
    });
  }
}
