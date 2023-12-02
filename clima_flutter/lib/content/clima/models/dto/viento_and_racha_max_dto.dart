import 'package:ClimaFlutter/content/clima/models/direccion.dart';

class VientoAndRachaMaxDto {
  final List<Direccion> direccion;
  final List<int> velocidad;
  final String periodo;

  VientoAndRachaMaxDto({
    required this.direccion,
    required this.velocidad,
    required this.periodo,
  });

  factory VientoAndRachaMaxDto.fromJson(Map<String, dynamic> json) {
    return VientoAndRachaMaxDto(
      direccion: json['direccion'] != null
          ? List<Direccion>.from(
              json['direccion'].map((x) => Direccion.values.byName(x)),
            )
          : [],
      velocidad: json['velocidad'] != null
          ? List<int>.from(
              json['velocidad'].map((x) => int.tryParse(x) ?? 0),
            )
          : [],
      periodo: json['periodo'],
    );
  }
}
