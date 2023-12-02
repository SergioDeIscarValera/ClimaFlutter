class MathUtils {
  static final MathUtils _instance = MathUtils._internal();

  factory MathUtils() {
    return _instance;
  }

  MathUtils._internal();

  int sum(Iterable<int> numbers) {
    int result = 0;
    for (int number in numbers) {
      result += number;
    }
    return result;
  }
}
