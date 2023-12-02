import 'package:get/get_utils/get_utils.dart';

class FormValidator {
  String? isValidName(String? text) {
    if (text == null || text.isEmpty || text.length < 3) {
      return "name_error".tr;
    }
    return null;
  }

  String? isValidEmail(String? text) {
    return (text ?? "").isEmail ? null : "email_error".tr;
  }

  String? isValidPass(String? text) {
    if (text == null || text.length < 6) {
      return "pass_error".tr;
    }
    return null;
  }
}
