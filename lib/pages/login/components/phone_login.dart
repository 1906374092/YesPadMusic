
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/component/common_button.dart';
import 'package:yes_play_music/pages/login/blocs/phone_login_bloc.dart';
import 'package:yes_play_music/pages/login/components/login_textfield.dart';
import 'package:yes_play_music/pages/login/data/phone_login_repostory.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/size.dart';

class PhoneLoginComponent extends StatefulWidget {
  const PhoneLoginComponent({super.key});

  @override
  State<PhoneLoginComponent> createState() => _PhoneLoginComponentState();
}

class _PhoneLoginComponentState extends State<PhoneLoginComponent> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double componentWidth = SizeUtil.screenWidth(context) / 3;
    return BlocProvider(
      create: (context) => PhoneLoginBloc(repository: PhoneLoginRepository()),
      child: BlocListener<PhoneLoginBloc, PhoneLoginState>(
        listener: (context, state) {
          if (state is InputPhoneNumState) {
            _pageController.animateToPage(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          } else if (state is InputSMSCodeState) {
            _pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
          if (state is PhoneLoginSuccessState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<PhoneLoginBloc, PhoneLoginState>(
            builder: (context, state) {
          return Container(
            height: SizeUtil.screenHeight(context) - 370,
            padding: const EdgeInsets.only(top: 30),
            child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Column(
                    children: [
                      LoginTextfield(
                        value: state.phoneNum,
                        keyboardType: TextInputType.number,
                        placeHolder: '手机号',
                        prefixIcon: Icons.phone_android,
                        prefixText: '+86',
                        onChanged: (value) {
                          context
                              .read<PhoneLoginBloc>()
                              .add(PhoneNumChangedEvent(phoneText: value));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CommonButton(
                          onTap: () {
                            context.read<PhoneLoginBloc>().add(GoToSMSEvent());
                          },
                          width: componentWidth,
                          title: '登录',
                          disable: !state.phoneNumValidate,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LoginTextfield(
                        placeHolder: '请输入验证码',
                        prefixIcon: Icons.email,
                        limitLength: 4,
                        onChanged: (value) {
                          if (value.length == 4) {
                            context
                                .read<PhoneLoginBloc>()
                                .add(LoginRequestEvent(smsCode: value));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextButton(
                            onPressed: () {
                              if (state.count == 0) {
                                context
                                    .read<PhoneLoginBloc>()
                                    .add(GoToSMSEvent());
                              }
                            },
                            child: Text(
                              state.count == 0
                                  ? '重新发送验证码'
                                  : '${state.count}s后可重新发送短信验证码',
                              style: TextStyle(
                                  color: state.count == 0
                                      ? ColorUtil.commonLightBlue
                                      : ColorUtil.commonLightGrey),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CommonButton(
                          width: componentWidth,
                          title: '返回',
                          onTap: () {
                            context
                                .read<PhoneLoginBloc>()
                                .add(GoToPhoneNumEvent());
                          },
                        ),
                      )
                    ],
                  )
                ]),
          );
        }),
      ),
    );
  }
}
