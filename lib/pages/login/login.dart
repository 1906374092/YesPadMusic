import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/login/blocs/login_page_bloc.dart';
import 'package:yes_play_music/pages/login/components/email_login.dart';
import 'package:yes_play_music/pages/login/components/phone_login.dart';
import 'package:yes_play_music/pages/login/components/qrcode_login.dart';
import 'package:yes_play_music/utils/eventbus.dart';
import 'package:yes_play_music/utils/size.dart';

class QRCodeLoginPageClosedEvent {
  const QRCodeLoginPageClosedEvent();
}

class PhoneLoginPageCloseEvent {
  const PhoneLoginPageCloseEvent();
}

class CloseKeyboardEvent {
  const CloseKeyboardEvent();
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
            backgroundColor: themeState.backgroundColor,
            appBar: CommonAppBar(
              title: '登录网易云账号',
              closeCallback: () {
                CommonEventBus.instance
                    .fire(const QRCodeLoginPageClosedEvent());
                CommonEventBus.instance.fire(const PhoneLoginPageCloseEvent());
              },
            ),
            body: GestureDetector(
              onTap: () {
                //收起键盘
                CommonEventBus.instance.fire(const CloseKeyboardEvent());
              },
              child: SingleChildScrollView(
                child: Container(
                  height: SizeUtil.screenHeight(context) - 84,
                  padding: const EdgeInsets.only(
                      top: 30,
                      // left: SizeUtil.screenWidth(context) / 4,
                      // right: SizeUtil.screenWidth(context) / 4,
                      bottom: 30),
                  child: SizedBox(
                    width: SizeUtil.screenWidth(context),
                    height: SizeUtil.screenHeight(context) - 60,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image(image: AssetImages.neteaseMusic),
                        ),
                        BlocBuilder<LoginFormBloc, LoginFormState>(
                          builder: (context, state) {
                            double buttonsSize =
                                SizeUtil.screenWidth(context) / 4;
                            Widget getComponent(LoginFormState formState) {
                              if (formState is EmailFormState) {
                                return const EmailLoginComponent();
                              } else if (formState is PhoneNumberFormState) {
                                return const PhoneLoginComponent();
                              } else {
                                return const QRCodeLoginComponent();
                              }
                            }

                            List<Map<String, dynamic>> buttons = [
                              {
                                'title': '二维码登录',
                                'action': () {
                                  context
                                      .read<LoginFormBloc>()
                                      .add(QRCodeLoginAction());
                                }
                              },
                              {
                                'title': '邮箱登录',
                                'action': () {
                                  context
                                      .read<LoginFormBloc>()
                                      .add(EmailLoginAction());
                                }
                              },
                              {
                                'title': '手机登录',
                                'action': () {
                                  context
                                      .read<LoginFormBloc>()
                                      .add(PhoneNumberLoginAction());
                                }
                              },
                            ];
                            List finalButtons = [];
                            for (Map<String, dynamic> element in buttons) {
                              if (element['title'] != state.title) {
                                finalButtons.add(element);
                              }
                            }
                            return Column(
                              children: [
                                getComponent(state),
                                Container(
                                  width: buttonsSize,
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 30),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: finalButtons[0]['action'],
                                          child:
                                              Text(finalButtons[0]['title'])),
                                      const Spacer(),
                                      Container(
                                        width: 1,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                          onPressed: finalButtons[1]['action'],
                                          child:
                                              Text(finalButtons[1]['title'])),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const Spacer(),
                        SizedBox(
                          width: SizeUtil.screenWidth(context) / 2,
                          child: Text(
                            'YesPlayMusic 承诺不会保存你的任何账号信息到云端。你的密码会在本地进行 MD5 加密后再传输到网易云 API。YesPlayMusic 并非网易云官方网站，输入账号信息前请慎重考虑。 你也可以前往 YesPlayMusic 的 GitHub 源代码仓库 自行构建并使用自托管的网易云 API。',
                            style: TextStyle(
                                color: themeState.secondTextColor,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
