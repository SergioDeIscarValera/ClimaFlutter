class EstadoCieloDto {
  final int value;
  final String? periodo;
  final String descripcion;

  EstadoCieloDto({
    required this.value,
    required this.periodo,
    required this.descripcion,
  });

  factory EstadoCieloDto.fromJson(Map<String, dynamic> json) {
    return EstadoCieloDto(
      value: int.tryParse(json['value']) ?? 0,
      periodo: json['periodo'],
      descripcion: json['descripcion'],
    );
  }
}
