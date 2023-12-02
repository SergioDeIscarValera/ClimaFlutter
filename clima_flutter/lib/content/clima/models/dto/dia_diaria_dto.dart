import 'package:ClimaFlutter/content/clima/models/weathre_long.dart';
import 'package:ClimaFlutter/content/clima/utils/json_utils.dart';

import 'dia_dto.dart';
import 'estado_cielo_dto.dart';
import 'max_min_value_dto.dart';
import 'value_periodic_dto.dart';
import 'viento_dto.dart';

class DiaDiariaDto extends DiaDto {
  final List<VientoDto> vientoList;
  final List<ValuePeriodicDto<String>> rachaMax;
  final MaxMinValueDto temperatura;
  final MaxMinValueDto sensTermica;
  final MaxMinValueDto humedadRelativa;
  final int? uvMax;

  DiaDiariaDto({
    required this.vientoList,
    required this.rachaMax,
    required this.temperatura,
    required this.sensTermica,
    required this.humedadRelativa,
    this.uvMax,
    required DateTime fecha,
    required List<ValuePeriodicDto<int>> probPrecipitacion,
    required List<ValuePeriodicDto<int>> cotaNieveProv,
    required List<EstadoCieloDto> estadoCielo,
  }) : super(
          probPrecipitacion: probPrecipitacion,
          cotaNieveProv: cotaNieveProv,
          estadoCielo: estadoCielo,
          fecha: fecha,
        );

  static DiaDto fromJson(Map<String, dynamic> json) {
    return DiaDiariaDto(
      vientoList: List<VientoDto>.from(
          json['viento'].map((x) => VientoDto.fromJson(x))),
      rachaMax: List<ValuePeriodicDto<String>>.from(json['rachaMax'].map((x) =>
          ValuePeriodicDto.fromJson<String>(x, JsonUtils.fromJsonString, ""))),
      temperatura: MaxMinValueDto.fromJson(json['temperatura']),
      sensTermica: MaxMinValueDto.fromJson(json['sensTermica']),
      humedadRelativa: MaxMinValueDto.fromJson(json['humedadRelativa']),
      uvMax: json['uvMax'],
      fecha: DateTime.parse(json['fecha']),
      probPrecipitacion: List<ValuePeriodicDto<int>>.from(
          json['probPrecipitacion'].map((x) =>
              ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      cotaNieveProv: List<ValuePeriodicDto<int>>.from(json['cotaNieveProv'].map(
          (x) => ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      estadoCielo: List<EstadoCieloDto>.from(
          json['estadoCielo'].map((x) => EstadoCieloDto.fromJson(x))),
    );
  }

  @override
  int get temperaturaMax => temperatura.maxima;

  @override
  int get temperaturaMin => temperatura.minima;

  @override
  int get viento =>
      vientoList
          .map((e) => e.velocidad)
          .reduce((value, element) => value + element) ~/
      vientoList.length;

  @override
  WeatherLong toWeatherLong(String provincia, String nombre) {
    return WeatherLong(
      municipio: nombre,
      provincia: provincia,
      fecha: fecha,
      temperaturaHora: _minMax24Hours(temperatura),
      sensTermicaHora: _minMax24Hours(sensTermica),
      probPrecipitacionHora: _pair24Hour(
        map: {for (var e in probPrecipitacion) e.periodo: e.value},
      ),
      vientoHora: _pair24Hour(
        map: {
          for (var e in vientoList.where((element) => element.periodo != null))
            e.periodo!: e.velocidad
        },
      ),
      nubesHora: _pair24Hour(
        map: {
          for (var e in estadoCielo.where((element) => element.periodo != null))
            e.periodo!: e.value
        },
      ),
      nieveHora: _pair24Hour(
        map: {for (var e in cotaNieveProv) e.periodo: e.value},
      ),
      uvMax: uvMax,
      salidaSol: null,
      puestaSol: null,
    );
  }

  List<int> _minMax24Hours(MaxMinValueDto maxMinValueDto) {
    //Rellenar las horas no explicitas con el utilimo valor explocito, pero la separación entre horas explicitas es variable
    final mapSorted = maxMinValueDto.dato
        .map((e) => MapEntry(e.hora, e.value))
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    // Añadir a mapSorted las horas no explicitas (hasta 24)
    int lastExplicitValue = mapSorted.last.value;
    for (int i = 0; i < 24; i++) {
      if (mapSorted.where((element) => element.key == i).isEmpty) {
        mapSorted.add(MapEntry(i, lastExplicitValue));
      } else {
        lastExplicitValue =
            mapSorted.where((element) => element.key == i).first.value;
      }
    }

    return mapSorted.map((e) => e.value).toList();
  }

  List<int> _pair24Hour({required Map<String, int> map}) {
    /*
    "probPrecipitacion" : [ {
        "value" : 0,
        "periodo" : "00-24"
      }, {
        "value" : 0,
        "periodo" : "00-12"
      }, {
        "value" : 0,
        "periodo" : "12-24"
      }, {
        "value" : 0,
        "periodo" : "00-06"
      }, {
        "value" : 0,
        "periodo" : "06-12"
      }, {
        "value" : 0,
        "periodo" : "12-18"
      }, {
        "value" : 0,
        "periodo" : "18-24"
      } ],*/
    //Rellenar las horas no explicitas con el utilimo valor explocito, pero la separación entre horas explicitas es variable
    List<int> probPrecipitacionHours = List.filled(24, 0);
    map.forEach((key, value) {
      var splited = key.split("-");
      int start = int.parse(splited[0]);
      int end = int.parse(splited[1]);
      for (int i = start; i < end; i++) {
        probPrecipitacionHours[i] = value;
      }
    });
    return probPrecipitacionHours;
  }
}
