import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/loading.dart';
import 'package:yes_play_music/pages/login/blocs/qrcode_login_bloc.dart';
import 'package:yes_play_music/pages/login/data/qr_login_repository.dart';
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
            context.read<AuthBloc>().add(LoginEvent());
            context.read<QRCodeLoginBloc>().checkQRScanStatusTimer.cancel();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<QRCodeLoginBloc, QRCodeState>(
                builder: (context, state) {
              double codeImageSize = SizeUtil.screenWidth(context) / 4;
              if (state is LoadingQRCodeState) {
                return SizedBox(
                    width: codeImageSize,
                    height: codeImageSize + 88,
                    child: const Loading(
                      status: '正在加载二维码',
                    ));
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
                  child: const Text('error'),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
