import 'package:crypto/crypto.dart';
import 'dart:convert';

class SaltService {
  static String getSign(Map map) {
    List keys = map.keys.toList();
    keys.sort();
    String result = "";
    keys.forEach((key) {
      result += key + map[key];
    });

    return md5.convert(utf8.encode(result)).toString();
  }
}
