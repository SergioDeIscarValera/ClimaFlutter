import 'dart:math';
import 'package:clima_console/models/dto/dia_dto.dart';
import 'package:clima_console/models/weathre_long.dart';
import 'package:clima_console/utils/json_utils.dart';
import 'package:clima_console/utils/my_localizations.dart';

import 'estado_cielo_dto.dart';
import 'value_periodic_dto.dart';
import 'viento_and_racha_max_dto.dart';

class DiaHorariaDto extends DiaDto {
  final List<VientoAndRachaMaxDto> vientoAndRachaMax;
  final List<ValuePeriodicDto<int>> temperatura;
  final List<ValuePeriodicDto<int>> sensTermica;
  final List<ValuePeriodicDto<int>> humedadRelativa;
  final DateTime salidaSol;
  final DateTime puestaSol;

  DiaHorariaDto({
    required this.vientoAndRachaMax,
    required this.temperatura,
    required this.sensTermica,
    required this.humedadRelativa,
    required DateTime fecha,
    required List<ValuePeriodicDto<int>> probPrecipitacion,
    required List<ValuePeriodicDto<int>> cotaNieveProv,
    required List<EstadoCieloDto> estadoCielo,
    required this.salidaSol,
    required this.puestaSol,
  }) : super(
          probPrecipitacion: probPrecipitacion,
          cotaNieveProv: cotaNieveProv,
          estadoCielo: estadoCielo,
          fecha: fecha,
        );

  static DiaDto fromJson(Map<String, dynamic> json) {
    return DiaHorariaDto(
      vientoAndRachaMax: List<VientoAndRachaMaxDto>.from(
          json['vientoAndRachaMax']
              .map((x) => VientoAndRachaMaxDto.fromJson(x))),
      temperatura: List<ValuePeriodicDto<int>>.from(json['temperatura'].map(
          (x) => ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      sensTermica: List<ValuePeriodicDto<int>>.from(json['sensTermica'].map(
          (x) => ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      humedadRelativa: List<ValuePeriodicDto<int>>.from(json['humedadRelativa']
          .map((x) =>
              ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      fecha: DateTime.parse(json['fecha']),
      probPrecipitacion: List<ValuePeriodicDto<int>>.from(
          json['probPrecipitacion'].map((x) =>
              ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      cotaNieveProv: List<ValuePeriodicDto<int>>.from(json['nieve'].map(
          (x) => ValuePeriodicDto.fromJson<int>(x, JsonUtils.fromJsonInt, 0))),
      estadoCielo: List<EstadoCieloDto>.from(
          json['estadoCielo'].map((x) => EstadoCieloDto.fromJson(x))),
      salidaSol: MyLocalizations.parseTime(json['orto']),
      puestaSol: MyLocalizations.parseTime(
        json['ocaso'],
      ),
    );
  }

  @override
  int get temperaturaMax => temperatura.map((e) => e.value).reduce(max);

  @override
  int get temperaturaMin => temperatura.map((e) => e.value).reduce(min);

  @override
  int get viento =>
      vientoAndRachaMax
          .where((e) => e.velocidad.isNotEmpty)
          .map((e) =>
              (e.velocidad.reduce((value, element) => value + element) ~/
                  e.velocidad.length))
          .reduce((value, element) => value + element) ~/
      vientoAndRachaMax.length;

  @override
  WeatherLong toWeatherLong(String provincia, String nombre) {
    return WeatherLong(
      municipio: nombre,
      provincia: provincia,
      fecha: fecha,
      temperaturaHora: _fill24HoursPair(temperatura),
      sensTermicaHora: _fill24HoursPair(sensTermica),
      probPrecipitacionHora: _fill24HoursRarePeriod(probPrecipitacion),
      vientoHora: _fill24Hours({
        for (var e in vientoAndRachaMax
            .where((element) => element.velocidad.isNotEmpty))
          e.periodo: (e.velocidad.reduce((value, element) => value + element) ~/
              e.velocidad.length)
      }),
      nubesHora: _fill24Hours({
        for (var e in estadoCielo.where((element) => element.periodo != null))
          e.periodo!: e.value
      }),
      nieveHora: _fill24HoursPair(cotaNieveProv),
      salidaSol: salidaSol,
      puestaSol: puestaSol,
    );
  }

  List<int> _fill24HoursPair(List<ValuePeriodicDto<int>> valuePriodics) {
    return _fill24Hours(
      {for (var e in valuePriodics) e.periodo: e.value},
    );
  }

  List<int> _fill24Hours(Map<String, int> map) {
    final List<int> result = List.filled(24, 0);
    int lastExplicitValue = map.values.last;
    for (int i = 0; i < result.length; i++) {
      //int? value = valuePriodics.where((element) => int.tryParse(element.periodo) == i).firstOrNull?.value;
      int? value = i < 10 ? map["0$i"] : map["$i"];
      if (value != null) {
        lastExplicitValue = value;
      }
      result[i] = value ?? lastExplicitValue;
    }
    return result;
  }

  List<int> _fill24HoursRarePeriod(List<ValuePeriodicDto<int>> valuePriodics) {
    /*"probPrecipitacion" : [ {
        "value" : "0",
        "periodo" : "0107"
      }, {
        "value" : "0",
        "periodo" : "0713"
      }, {
        "value" : "0",
        "periodo" : "1319"
      }, {
        "value" : "0",
        "periodo" : "1901"
      } ],*/
    // El perido son 4 digitos, los dos primeros son la hora de inicio y los dos ultimos la hora de fin
    // Hay que rellenar las horas no explicitas con el utilimo valor explocito, pero la separación entre horas explicitas es variable
    // y no comienza en 0 ni termina en 24
    final List<int> result = List.filled(24, 0);
    int lastExplicitValue = valuePriodics.firstOrNull?.value ?? 0;
    for (int i = 0; i < result.length; i++) {
      int? value = valuePriodics
          .where((element) =>
              int.parse(element.periodo.substring(0, 2)) <= i &&
              int.parse(element.periodo.substring(2, 4)) > i)
          .firstOrNull
          ?.value;
      if (value != null) {
        lastExplicitValue = value;
      }
      result[i] = value ?? lastExplicitValue;
    }
    return result;
  }
}
