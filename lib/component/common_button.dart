import 'package:flutter/material.dart';
import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/eventbus.dart';

class CommonButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String? title;
  final bool? disable;
  final Function() onTap;
  const CommonButton(
      {super.key,
      this.width = 200,
      this.height = 50,
      this.title,
      this.disable = false,
      required this.onTap});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.disable!
              ? ColorUtil.fromHex('#EEEEEE')
              : ColorUtil.fromHex('#E7ECFC')),
      clipBehavior: Clip.hardEdge,
      child: MaterialButton(
        onPressed: widget.disable!
            ? null
            : () {
                CommonEventBus.instance.fire(const CloseKeyboardEvent());
                widget.onTap();
              },
        color: ColorUtil.fromHex('#E7ECFC'),
        enableFeedback: widget.disable!,
        child: Text(
          widget.title ?? '',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.disable!
                  ? ColorUtil.fromHex('#ADADAD')
                  : ColorUtil.fromHex('#304DE3')),
        ),
      ),
    );
  }
}
