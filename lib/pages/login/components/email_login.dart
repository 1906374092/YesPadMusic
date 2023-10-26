import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/component/common_button.dart';
import 'package:yes_play_music/pages/login/blocs/email_login_bloc.dart';
import 'package:yes_play_music/pages/login/components/login_textfield.dart';
import 'package:yes_play_music/pages/login/data/email_login_repository.dart';
import 'package:yes_play_music/utils/size.dart';

class EmailLoginComponent extends StatelessWidget {
  const EmailLoginComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double componentWidth = SizeUtil.screenWidth(context) / 3;
    return BlocProvider(
      create: (context) => EmailLoginBloc(repository: EmailLoginRepository()),
      child: BlocBuilder<EmailLoginBloc, EmailLoginState>(
        builder: (context, state) {
          return Container(
            height: SizeUtil.screenHeight(context) - 370,
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                LoginTextfield(
                  placeHolder: '邮箱',
                  prefixIcon: Icons.email,
                  onComplete: (String value) {
                    context
                        .read<EmailLoginBloc>()
                        .add(ValidateEmailAction(emailText: value));
                  },
                  onUnfocus: (value) {
                    context
                        .read<EmailLoginBloc>()
                        .add(ValidateEmailAction(emailText: value));
                  },
                ),
                LoginTextfield(
                  placeHolder: '密码',
                  prefixIcon: Icons.lock,
                  isSecue: true,
                  onChanged: (value) {
                    context
                        .read<EmailLoginBloc>()
                        .add(ValidatePasswordAction(password: value));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CommonButton(
                    width: componentWidth,
                    title: '登录',
                    disable: state is EmailLoginUnValidateState,
                    onTap: () {
                      context
                          .read<EmailLoginBloc>()
                          .add(SendEmailLoginRequestAction());
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
