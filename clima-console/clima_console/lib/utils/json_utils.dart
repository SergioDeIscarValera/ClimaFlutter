class JsonUtils {
  static int fromJsonInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return value ?? 0;
  }

  static String fromJsonString(dynamic value) {
    if (value is String) {
      return value;
    }
    return value.toString();
  }
}
