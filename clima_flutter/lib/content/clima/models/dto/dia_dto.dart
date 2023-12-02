import 'package:ClimaFlutter/content/clima/models/dto/dia_diaria_dto.dart';
import 'package:ClimaFlutter/content/clima/models/dto/dia_horaria_dto.dart';
import 'package:ClimaFlutter/content/clima/models/weather_small.dart';
import 'package:ClimaFlutter/content/clima/models/weathre_long.dart';
import 'package:collection/collection.dart';

import 'estado_cielo_dto.dart';
import 'value_periodic_dto.dart';

abstract class DiaDto {
  final List<ValuePeriodicDto<int>> probPrecipitacion;
  final List<ValuePeriodicDto<int>> cotaNieveProv;
  final List<EstadoCieloDto> estadoCielo;
  final DateTime fecha;

  DiaDto({
    required this.probPrecipitacion,
    required this.cotaNieveProv,
    required this.estadoCielo,
    required this.fecha,
  });

  // Perdoname uncle Bob, pero es lo que hay :(
  factory DiaDto.fromJson(Map<String, dynamic> json, int type) {
    switch (type) {
      case 0:
        return DiaDiariaDto.fromJson(json);
      case 1:
        return DiaHorariaDto.fromJson(json);
      default:
        return DiaDiariaDto.fromJson(json);
    }
  }
  int get temperaturaMin;
  int get temperaturaMax;
  int get viento;

  WeatherSmall toWeatherSmall(String provincia, String nombre) {
    return WeatherSmall(
      provincia: provincia,
      municipio: nombre,
      fecha: fecha,
      probPrecipitacion:
          probPrecipitacion.map((e) => e.value).sum ~/ probPrecipitacion.length,
      temperaturaMin: temperaturaMin,
      temperaturaMax: temperaturaMax,
      viento: viento,
      nubes: estadoCielo.map((e) => e.value).sum ~/ estadoCielo.length,
      // Descripccion del estado del cielo más repetido (moda)
      estadoCielo: estadoCielo.map((e) => e.descripcion).toList().reduce(
          (value, element) =>
              estadoCielo.where((e) => e.descripcion == value).length >
                      estadoCielo.where((e) => e.descripcion == element).length
                  ? value
                  : element),
    );
  }

  WeatherLong toWeatherLong(String provincia, String nombre);
}
