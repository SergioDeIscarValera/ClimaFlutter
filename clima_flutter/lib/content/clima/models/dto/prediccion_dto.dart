import 'dia_dto.dart';

class PrediccionDto {
  final List<DiaDto> dia;

  PrediccionDto({
    required this.dia,
  });

  factory PrediccionDto.fromJson(Map<String, dynamic> json, int type) {
    return PrediccionDto(
      dia: List<DiaDto>.from(json["dia"].map((x) => DiaDto.fromJson(x, type))),
    );
  }
}
