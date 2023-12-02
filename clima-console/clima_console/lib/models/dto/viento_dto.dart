class VientoDto {
  final String direccion;
  final int velocidad;
  final String? periodo;

  VientoDto({
    required this.direccion,
    required this.velocidad,
    required this.periodo,
  });

  factory VientoDto.fromJson(Map<String, dynamic> json) {
    return VientoDto(
      direccion: json['direccion'],
      velocidad: json['velocidad'],
      periodo: json['periodo'],
    );
  }
}
