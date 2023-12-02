class ValuePeriodicDto<T> {
  final T value;
  final String periodo;

  ValuePeriodicDto({
    required this.value,
    required this.periodo,
  });

  static ValuePeriodicDto<T> fromJson<T>(
      Map<String, dynamic> json, T? Function(dynamic) fromJsonFunc, T ifNull) {
    return ValuePeriodicDto<T>(
      value: fromJsonFunc(json['value']) ?? ifNull,
      periodo: json['periodo'] ?? "",
    );
  }
}
