class DatoDto {
  final int value;
  final int hora;

  DatoDto({
    required this.value,
    required this.hora,
  });

  factory DatoDto.fromJson(Map<String, dynamic> json) {
    return DatoDto(
      value: json['value'],
      hora: json['hora'],
    );
  }
}
