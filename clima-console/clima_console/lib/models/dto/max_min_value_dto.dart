import 'dato_dto.dart';

class MaxMinValueDto {
  final int maxima;
  final int minima;
  final List<DatoDto> dato;

  MaxMinValueDto({
    required this.maxima,
    required this.minima,
    required this.dato,
  });

  factory MaxMinValueDto.fromJson(Map<dynamic, dynamic> json) {
    return MaxMinValueDto(
      maxima: json['maxima'],
      minima: json['minima'],
      dato: List<DatoDto>.from(json['dato'].map((x) => DatoDto.fromJson(x))),
    );
  }
}
