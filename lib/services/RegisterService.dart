class RegisterService {
  // 以1开头的11位手机号校验
  static bool checkNumber(String str) => RegExp(r"^1[0-9]{10}$").hasMatch(str);
  // 验证码校验
  static bool checkCode(sourceCode, targetCode) =>
      sourceCode.toLowerCase() == targetCode.toLowerCase();
}
