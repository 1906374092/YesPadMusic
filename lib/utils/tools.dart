import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Tools {
  static bool buttonTapLock = false;

  static String getNumberLabel(int number) {
    if (number ~/ 10000 < 10) {
      return number.toString();
    } else if (number ~/ 10000 > 10 && number ~/ 10000 < 10000) {
      return "${number ~/ 10000}万";
    } else {
      return "${number ~/ 100000000}亿";
    }
  }

  static int getTimeIntervalWithOffset({int dayoffset = 0}) {
    DateTime now = DateTime.now();
    DateTime base = DateTime(now.year, now.month, now.day + dayoffset);
    return base.millisecondsSinceEpoch;
  }

  static int getNowTimeInterval() {
    return DateTime.now().microsecondsSinceEpoch;
  }

  static String getDateString(int interval) {
    DateTime resultDate = DateTime.fromMillisecondsSinceEpoch(interval);
    DateTime now = DateTime.now();
    if (resultDate.year == now.year &&
        resultDate.month == now.month &&
        resultDate.day == now.day) {
      return "今天";
    } else if (resultDate.year == now.year &&
        resultDate.month == now.month &&
        resultDate.day == now.day + 1) {
      return "明天";
    } else if (resultDate.year == now.year &&
        resultDate.month == now.month &&
        resultDate.day == now.day + 2) {
      return "后天";
    } else {
      return "${resultDate.month}月${resultDate.day}日";
    }
  }

  static setButtonLock(Function handler, {millseconds = 800}) {
    if (!Tools.buttonTapLock) {
      Tools.buttonTapLock = true;
      handler();
      Future.delayed(Duration(milliseconds: millseconds), () {
        Tools.buttonTapLock = false;
      });
    }
  }

  ///00:00.000
  static Duration timeStringToDuration(String timeString) {
    String minute = timeString.split(":")[0];
    String second = timeString.split(":")[1].split(".")[0];
    String millSecond = timeString.split(":")[1].split(".")[1];
    int total = int.parse(minute) * 60 * 1000 +
        int.parse(second) * 1000 +
        int.parse(millSecond);
    return Duration(milliseconds: total);
  }

  static String getFullDateTimeString(int timeInterval) {
    DateTime resultDate = DateTime.fromMillisecondsSinceEpoch(timeInterval);
    return "${resultDate.year}年${resultDate.month}月${resultDate.day}日";
  }

  //图片防盗链
  static String imageTransfer(String imageUrl, {int size = 300}) {
    return 'https://images.weserv.nl/?url=$imageUrl?param=${size}y$size';
  }

  static showToast(String message) {
    EasyLoading.showToast(message);
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  static String placeholderImageUrl() {
    return 'https://gimg3.baidu.com/topone/src=https%3A%2F%2Fbkimg.cdn.bcebos.com%2Fpic%2F838ba61ea8d3fd1fa92d29173d4e251f95ca5ff3%3Fx-bce-process%3Dimage%2Fresize%2Cm_pad%2Cw_348%2Ch_348%2Ccolor_ffffff&refer=http%3A%2F%2Fwww.baidu.com&app=2011&size=f200,200&n=0&g=0n&er=404&q=75&fmt=auto&maxorilen2heic=2000000?sec=1698253200&t=a6023e6698ac78176f75d728169641c0';
  }

  static String timeStringFromNum(num timecount) {
    num minute = timecount / 1000 ~/ 60;
    num seconds = timecount ~/ 1000 % 60;
    String minuteStr = minute > 9 ? minute.toString() : '0$minute';
    String secondStr = seconds > 9 ? seconds.toString() : '0$seconds';
    return '$minuteStr:$secondStr';
  }

  //00:00.00
  static num timeCountFromString(String timeStr) {
    List temp1 = timeStr.split(':');
    num minute = num.parse((temp1[0] as String));
    List temp2 = (temp1[1] as String).split('.');
    num second = num.parse((temp2[0] as String));
    num millSecond = num.parse((temp2[1] as String));

    return minute * 60 * 1000 + second * 1000 + millSecond;
  }
}
