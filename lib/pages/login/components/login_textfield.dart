import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/eventbus.dart';
import 'package:yes_play_music/utils/size.dart';

class LoginTextfield extends StatefulWidget {
  final String? placeHolder;
  final IconData? prefixIcon;
  final bool? isSecue;
  final Function(String value)? onChanged;
  final Function(String value)? onComplete;
  final Function(String value)? onUnfocus;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? value;
  final int? limitLength;
  const LoginTextfield(
      {super.key,
      this.placeHolder = '请输入',
      this.prefixIcon = Icons.email,
      this.isSecue = false,
      this.onChanged,
      this.onComplete,
      this.onUnfocus,
      this.prefixText = '',
      this.keyboardType,
      this.value = '',
      this.limitLength});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _hasFocus = true;
        } else {
          if (widget.onUnfocus != null) widget.onUnfocus!(_controller.text);
          _hasFocus = false;
        }
      });
    });
    CommonEventBus.instance.listen<CloseKeyboardEvent>((event) {
      _focusNode.unfocus();
    });
    _controller.text = widget.value!;

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = SizeUtil.screenWidth(context) / 3;
    Color backgroundColor =
        _hasFocus ? ColorUtil.fromHex('#E7ECFC') : ColorUtil.fromHex('#F3F3F6');
    return Container(
      width: size,
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: widget.keyboardType ?? TextInputType.text,
        controller: _controller,
        onChanged: (value) =>
            widget.onChanged == null ? null : widget.onChanged!(value),
        onEditingComplete: widget.onComplete == null
            ? null
            : () => widget.onComplete!(_controller.text),
        obscureText: widget.isSecue!,
        focusNode: _focusNode,
        inputFormatters: widget.limitLength == null
            ? null
            : <TextInputFormatter>[
                LengthLimitingTextInputFormatter(widget.limitLength)
              ],
        style: TextStyle(
            backgroundColor: backgroundColor,
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Container(
            padding: const EdgeInsets.only(left: 5),
            width: widget.prefixText! == '' ? 35 : 70,
            child: Row(
              children: [
                Icon(widget.prefixIcon),
                Text(
                  widget.prefixText!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          hintText: widget.placeHolder,
        ),
      ),
    );
  }
}
