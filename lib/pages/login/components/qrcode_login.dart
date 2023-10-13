import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/pages/login/blocs/qrcode_login_bloc.dart';
import 'package:yes_play_music/pages/login/data/login_repository.dart';
import 'package:yes_play_music/utils/size.dart';

class QRCodeLoginComponent extends StatelessWidget {
  const QRCodeLoginComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRCodeLoginBloc(repository: QRCodeLoginRepository())
        ..add(GetQRCodeDataEvent()),
      child: BlocListener<QRCodeLoginBloc, QRCodeState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<QRCodeLoginBloc, QRCodeState>(
                builder: (context, state) {
              double codeImageSize = SizeUtil.screenWidth(context) / 4;
              if (state is LoadingQRCodeState) {
                return Container(
                  width: codeImageSize,
                  height: codeImageSize,
                  child: Text(
                    '二维码正在加载中',
                    style: TextStyle(color: themeState.mainTextColor),
                  ),
                );
              } else if (state is GotQRCodeState) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: themeState.lightBlueColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: codeImageSize,
                      height: codeImageSize,
                      child: Stack(
                        children: [
                          QrImageView(
                            data: state.qrUrl!,
                            dataModuleStyle: QrDataModuleStyle(
                                color: themeState.darkBlueColor,
                                dataModuleShape: QrDataModuleShape.square),
                            eyeStyle: QrEyeStyle(
                                color: themeState.darkBlueColor,
                                eyeShape: QrEyeShape.square),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      state.message!,
                      style: TextStyle(
                          color: themeState.mainTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                );
              } else {
                return Container(
                  child: Text('error'),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
