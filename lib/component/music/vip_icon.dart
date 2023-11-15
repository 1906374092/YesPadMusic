import 'package:flutter/material.dart';

class VipIcon extends StatelessWidget {
  const VipIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 13,
      margin: const EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(width: 1, color: Colors.red)),
      child: const Text(
        'vip',
        style: TextStyle(color: Colors.red, fontSize: 10),
      ),
    );
  }
}
