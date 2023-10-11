import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/login/blocs/login_page_bloc.dart';
import 'package:yes_play_music/pages/login/components/email_login.dart';
import 'package:yes_play_music/pages/login/components/phone_login.dart';
import 'package:yes_play_music/pages/login/components/qrcode_login.dart';
import 'package:yes_play_music/utils/size.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
            backgroundColor: themeState.backgroundColor,
            appBar: const CommonAppBar(
              title: '登录网易云账号',
            ),
            body: Container(
              padding: EdgeInsets.only(
                  top: 30,
                  left: SizeUtil.screenWidth(context) / 4,
                  right: SizeUtil.screenWidth(context) / 4,
                  bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(image: AssetImages.neteaseMusic),
                    ),
                    BlocBuilder<LoginFormBloc, LoginFormState>(
                      builder: (context, state) {
                        if (state is EmailFormState) {
                          return const EmailLoginComponent();
                        } else if (state is PhoneNumberFormState) {
                          return const PhoneLoginComponent();
                        } else {
                          return const QRCodeLoginComponent();
                        }
                      },
                    ),
                    Text(
                      'YesPlayMusic 承诺不会保存你的任何账号信息到云端。你的密码会在本地进行 MD5 加密后再传输到网易云 API。YesPlayMusic 并非网易云官方网站，输入账号信息前请慎重考虑。 你也可以前往 YesPlayMusic 的 GitHub 源代码仓库 自行构建并使用自托管的网易云 API。',
                      style: TextStyle(
                          color: themeState.secondTextColor, fontSize: 12),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
