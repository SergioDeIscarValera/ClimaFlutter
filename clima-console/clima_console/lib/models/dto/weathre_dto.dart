import 'package:clima_console/models/weather_small.dart';
import 'package:clima_console/models/weathre_long.dart';

import 'prediccion_dto.dart';

class WeatherDto {
  final DateTime elaborado;
  final String nombre;
  final String provincia;
  final PrediccionDto prediccion;

  WeatherDto({
    required this.elaborado,
    required this.nombre,
    required this.provincia,
    required this.prediccion,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json, int type) {
    return WeatherDto(
      elaborado: DateTime.parse(json["elaborado"]),
      nombre: json["nombre"],
      provincia: json["provincia"],
      prediccion: PrediccionDto.fromJson(json["prediccion"], type),
    );
  }

  List<WeatherSmall> castToWeatherSmallList() {
    return prediccion.dia
        .map((e) => e.toWeatherSmall(provincia, nombre))
        .toList();
  }

  List<WeatherLong> castToWeatherLongList() {
    return prediccion.dia
        .map((e) => e.toWeatherLong(provincia, nombre))
        .toList();
  }
}
