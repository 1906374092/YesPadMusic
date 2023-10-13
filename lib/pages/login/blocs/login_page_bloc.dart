import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/utils/global.dart';

sealed class LoginFormChangeEvent {}

class QRCodeLoginAction extends LoginFormChangeEvent {}

class EmailLoginAction extends LoginFormChangeEvent {}

class PhoneNumberLoginAction extends LoginFormChangeEvent {}

@immutable
sealed class LoginFormState extends Equatable {}

class QRCodeFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
}

class EmailFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
}

class PhoneNumberFormState extends LoginFormState {
  @override
  List<Object?> get props => [];
}

class LoginFormBloc extends Bloc<LoginFormChangeEvent, LoginFormState> {
  LoginFormBloc() : super(QRCodeFormState()) {
    on<QRCodeLoginAction>((event, emit) => emit(QRCodeFormState()));
    on<PhoneNumberLoginAction>((event, emit) => emit(PhoneNumberFormState()));
    on<EmailLoginAction>((event, emit) => emit(EmailFormState()));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    logger.e(error);
    super.onError(error, stackTrace);
  }
}
